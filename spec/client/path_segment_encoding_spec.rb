require "spec_helper"

describe "resource ID path encoding" do
  # An ID that tries to escape its path segment with every character that changes the request target.
  # IDs containing "/" or ";" are rejected rather than encoded (see SLASH_ID below).
  INJECTED_ID = "x?z#w%".freeze
  ENCODED_ID = "x%3Fz%23w%25".freeze

  # Okta decodes "%2F" back into a path separator, so an ID with a slash must never be sent.
  SLASH_ID = "00uX/factors".freeze

  CapturedRequest = Struct.new(:verb, :request_uri, :path, :params)

  # Sends requests through Faraday's built-in test adapter instead of the network, and records
  # every request Faraday was about to send. VCR is turned off so no cassette is consulted.
  def capture_requests(responses: nil, &block)
    captured = []
    stubs = Faraday::Adapter::Test::Stubs.new
    [:get, :post, :put, :delete].each do |verb|
      stubs.public_send(verb, /.*/) do |env|
        captured << CapturedRequest.new(env.method, env.url.request_uri, env.url.path, env.params)
        (responses && responses[captured.size - 1]) || [200, { "Content-Type" => "application/json" }, "{}"]
      end
    end
    connection = Faraday.new do |builder|
      builder.use(Oktakit::Response::RaiseError)
      builder.adapter(:test, stubs)
    end
    client.instance_variable_set(:@sawyer_agent, nil) # The client caches its agent; rebuild it on this stub.
    allow(client).to(receive(:sawyer_options).and_return(
      links_parser: Sawyer::LinkParsers::Simple.new,
      faraday: connection,
    ))

    VCR.turned_off { block.call(client) }
    captured
  end

  def capture_request(&block)
    requests = capture_requests(&block)
    expect(requests.size).to(eq(1))
    requests.first
  end

  describe "#get_user" do
    it "does not let a slash in the ID reach another endpoint" do
      requests = capture_requests do |c|
        expect { c.get_user(SLASH_ID) }.to(raise_error(ArgumentError, /Invalid path segment/))
      end

      expect(requests).to(be_empty)
    end
  end

  describe "path segment encoding" do
    {
      "00u6o0w6tyuPVEeZr0h7" => "00u6o0w6tyuPVEeZr0h7",
      "me" => "me",
      "user@example.com" => "user%40example.com",
      "first.last-name_x~y@example.com" => "first.last-name_x~y%40example.com",
      "user+tag@example.com" => "user%2Btag%40example.com",
      "00uX?expand=x" => "00uX%3Fexpand%3Dx",
      "00uX#fragment" => "00uX%23fragment",
      "100%" => "100%25",
      "00u%2Fx" => "00u%252Fx",
      "a b" => "a%20b",
      "a\\b" => "a%5Cb",
      "café" => "caf%C3%A9",
      "..." => "...",
      12345 => "12345",
      :symbol_id => "symbol_id",
    }.each do |input, encoded|
      it "sends #{input.inspect} as the single segment #{encoded}" do
        expect(capture_request { |c| c.get_user(input) }.request_uri).to(eq("/api/v1/users/#{encoded}"))
      end
    end

    [nil, "", ".", "..", "/", "00uX/factors", "user/name@example.com", "00uX;x", "00uX;"].each do |input|
      it "rejects #{input.inspect} without sending a request" do
        requests = capture_requests do |c|
          expect { c.get_user(input) }.to(raise_error(ArgumentError, /Invalid path segment/))
        end
        expect(requests).to(be_empty)
      end
    end

    it "does not let a dot segment turn a group membership removal into a user deletion" do
      requests = capture_requests do |c|
        expect { c.remove_user_from_group("..", "00uVictim") }.to(raise_error(ArgumentError))
      end
      expect(requests).to(be_empty)
    end
  end

  describe "request path escaping" do
    it "does not double-encode an existing percent escape" do
      expect(capture_request { |c| c.get("/users/x%2Fy") }.request_uri).to(eq("/api/v1/users/x%2Fy"))
    end

    it "encodes a percent sign that does not start an escape" do
      expect(capture_request { |c| c.get("/users/100%") }.request_uri).to(eq("/api/v1/users/100%25"))
    end

    it "encodes characters that are not allowed in a URL" do
      expect(capture_request { |c| c.get("/users/a b") }.request_uri).to(eq("/api/v1/users/a%20b"))
    end

    it "follows an already-encoded pagination link without double-encoding it" do
      next_link = '<https://okta-test.okta.com/api/v1/users?after=abc%3D&limit=1>; rel="next"'
      responses = [
        [200, { "Content-Type" => "application/json", "Link" => next_link }, "[{}]"],
        [200, { "Content-Type" => "application/json" }, "[{}]"],
      ]
      requests = capture_requests(responses: responses) { |c| c.list_users(paginate: true) }

      expect(requests.map(&:request_uri)).to(eq(["/api/v1/users", "/api/v1/users?after=abc%3D&limit=1"]))
    end
  end

  # Read, write, destructive, and nested helpers for each resource module. "Nested" means the ID is
  # followed by more path, or the path has more than one ID. Events takes no IDs. Templates has no
  # nested helpers.
  {
    "Users" => [
      [:get_user, [INJECTED_ID], :get, "/users/:id"],
      [:update_user, [INJECTED_ID], :put, "/users/:id"],
      [:update_user, [INJECTED_ID, { partial: true }], :post, "/users/:id"],
      [:delete_user, [INJECTED_ID], :delete, "/users/:id"],
      [:clear_user_sessions, [INJECTED_ID], :delete, "/users/:id/sessions"],
      [:get_member_groups, [INJECTED_ID], :get, "/users/:id/groups"],
      [:reset_password, [INJECTED_ID], :post, "/users/:id/lifecycle/reset_password"],
    ],
    "AdminRoles" => [
      [:list_roles_assigned_to_user, [INJECTED_ID], :get, "/users/:id/roles"],
      [:assign_role_to_user, [INJECTED_ID], :post, "/users/:id/roles"],
      [:unassign_role_from_user, [INJECTED_ID, INJECTED_ID], :delete, "/users/:id/roles/:id"],
      [
        :add_group_target_to_user_admin_role,
        [INJECTED_ID, INJECTED_ID, INJECTED_ID],
        :put,
        "/users/:id/roles/:id/targets/groups/:id",
      ],
      [
        :remove_app_target_from_app_admin_role,
        [INJECTED_ID, INJECTED_ID, INJECTED_ID],
        :delete,
        "/users/:id/roles/:id/targets/catalog/apps/:id",
      ],
    ],
    "Apps" => [
      [:get_application, [INJECTED_ID], :get, "/apps/:id"],
      [:update_application, [INJECTED_ID], :put, "/apps/:id"],
      [:delete_application, [INJECTED_ID], :delete, "/apps/:id"],
      [:remove_user_from_application, [INJECTED_ID, INJECTED_ID], :delete, "/apps/:id/users/:id"],
      [:get_key_credential_for_application, [INJECTED_ID, INJECTED_ID], :get, "/apps/:id/credentials/keys/:id"],
    ],
    "Factors" => [
      [:get_factor, [INJECTED_ID, INJECTED_ID], :get, "/users/:id/factors/:id"],
      [:enroll_factor, [INJECTED_ID], :post, "/users/:id/factors"],
      [:reset_factor, [INJECTED_ID, INJECTED_ID], :delete, "/users/:id/factors/:id"],
      [
        :poll_for_verify_transaction_completion,
        [INJECTED_ID, INJECTED_ID, INJECTED_ID],
        :get,
        "/users/:id/factors/:id/transactions/:id",
      ],
    ],
    "GroupRules" => [
      [:get_group_rule, [INJECTED_ID], :get, "/groups/rules/:id"],
      [:update_group_rule, [INJECTED_ID], :put, "/groups/rules/:id"],
      [:remove_group_rule, [INJECTED_ID], :delete, "/groups/rules/:id"],
      [:activate_group_rule, [INJECTED_ID], :post, "/groups/rules/:id/lifecycle/activate"],
    ],
    "Groups" => [
      [:get_group, [INJECTED_ID], :get, "/groups/:id"],
      [:update_group, [INJECTED_ID], :put, "/groups/:id"],
      [:remove_group, [INJECTED_ID], :delete, "/groups/:id"],
      [:remove_user_from_group, [INJECTED_ID, INJECTED_ID], :delete, "/groups/:id/users/:id"],
    ],
    "IdentityProviders" => [
      [:get_identity_provider, [INJECTED_ID], :get, "/idps/:id"],
      [:update_identity_provider, [INJECTED_ID], :put, "/idps/:id"],
      [:delete_identity_provider, [INJECTED_ID], :delete, "/idps/:id"],
      [:delete_key, [INJECTED_ID], :delete, "/idps/credentials/keys/:id"],
      [:link_idp_user, [INJECTED_ID, INJECTED_ID], :post, "/idps/tx/:id/lifecycle/confirm/:id"],
    ],
    "Schemas" => [
      [:get_app_user_schema, [INJECTED_ID], :get, "/meta/schemas/apps/:id/default"],
      [:add_property_to_app_user_profile_schema, [INJECTED_ID], :post, "/meta/schemas/apps/:id/default"],
      [:remove_property_from_app_user_profile_schema, [INJECTED_ID], :post, "/meta/schemas/apps/:id/default"],
    ],
    "Templates" => [
      [:get_sms_template, [INJECTED_ID], :get, "/templates/sms/:id"],
      [:update_sms_template, [INJECTED_ID], :put, "/templates/sms/:id"],
      [:partial_sms_template_update, [INJECTED_ID], :post, "/templates/sms/:id"],
      [:remove_sms_template, [INJECTED_ID], :delete, "/templates/sms/:id"],
    ],
  }.each do |resource, cases|
    describe resource do
      cases.each do |method_name, args, verb, path|
        expected_path = "/api/v1#{path.gsub(":id", ENCODED_ID)}"

        it "##{method_name} sends #{verb.upcase} #{expected_path}" do
          request = capture_request { |c| c.public_send(method_name, *args) }

          expect(request.verb).to(eq(verb))
          expect(request.request_uri).to(eq(expected_path))
        end
      end
    end
  end

  describe "every resource helper" do
    resource_modules = Oktakit::Client.included_modules.select { |mod| mod.name.to_s.start_with?("Oktakit::Client::") }
    # This helper sends its ID in query values rather than the path; see its own specs below.
    query_id_helpers = [:list_applications_assigned_to_user]

    resource_modules.each do |mod|
      mod.instance_methods(false).sort.each do |method_name|
        id_params = mod.instance_method(method_name).parameters.select { |type, _| type == :req }
        next if id_params.empty? || query_id_helpers.include?(method_name)

        helper = "#{mod.name.split("::").last}##{method_name}"

        it "#{helper} keeps every ID inside its own segment" do
          request = capture_request { |c| c.public_send(method_name, *Array.new(id_params.size, INJECTED_ID)) }

          expect(request.request_uri).not_to(include("x?z"))
          expect(request.path.scan(ENCODED_ID).size).to(eq(id_params.size))
        end

        it "#{helper} rejects a slash in any ID without sending a request" do
          id_params.size.times do |position|
            args = Array.new(id_params.size, "00uOk")
            args[position] = SLASH_ID
            requests = capture_requests do |c|
              expect { c.public_send(method_name, *args) }.to(raise_error(ArgumentError, /Invalid path segment/))
            end
            expect(requests).to(be_empty)
          end
        end
      end
    end
  end

  describe "#list_applications_assigned_to_user" do
    it "sends the user ID as a JSON-escaped filter literal and an expand value" do
      request = capture_request { |c| c.list_applications_assigned_to_user('00u"x\\y') }

      expect(request.path).to(eq("/api/v1/apps"))
      expect(request.params).to(eq("filter" => 'user.id eq "00u\\"x\\\\y"', "expand" => 'user/00u"x\\y'))
    end

    it "keeps query characters in the user ID inside the query values" do
      request = capture_request { |c| c.list_applications_assigned_to_user("00u1&limit=1") }

      expect(request.params).to(eq("filter" => 'user.id eq "00u1&limit=1"', "expand" => "user/00u1&limit=1"))
    end

    it "keeps other caller query params but overrides the caller's filter and expand" do
      request = capture_request do |c|
        c.list_applications_assigned_to_user(
          "00u1",
          query: { limit: 5, filter: 'status eq "ACTIVE"', "expand" => "user/00uOther" },
        )
      end

      expect(request.params).to(eq("limit" => "5", "filter" => 'user.id eq "00u1"', "expand" => "user/00u1"))
    end

    it "rejects an empty user ID without sending a request" do
      requests = capture_requests do |c|
        expect { c.list_applications_assigned_to_user(nil) }.to(raise_error(ArgumentError, /Invalid user ID/))
      end
      expect(requests).to(be_empty)
    end
  end
end
