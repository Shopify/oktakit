require "spec_helper"

describe Oktakit::Client::AuthorizationServers do
  AUTH_SERVER_ID = "aus4wmezfewflnJvd5d7"
  POLICY_ID = "00p4wmrrbjdlgXfcn5d7"

  describe "#add_authorization_server" do
    it "returns the created authorization server" do
      params = { "name" => "Sample Authorization Server",
                 "description" => "Sample Authorization Server description",
                 "audiences" => ["api://default"], }

      VCR.use_cassette("add_authorization_server") do
        resp, = client.add_authorization_server(params)
        expect(resp.id).to(be == AUTH_SERVER_ID)
      end
    end
  end

  describe "#get_authorization_server" do
    it "returns an authorization server" do
      VCR.use_cassette("get_authorization_server") do
        resp, = client.get_authorization_server(AUTH_SERVER_ID)
        expect(resp.id).to(be == AUTH_SERVER_ID)
      end
    end
  end

  describe "#list_authorization_servers" do
    it "returns an array of authorization servers" do
      VCR.use_cassette("list_authorization_servers") do
        resp, = client.list_authorization_servers
        expect(resp.map(&:id)).to(include(AUTH_SERVER_ID))
      end
    end
  end

  describe "#list_authorization_server_policies" do
    it "returns an array of policies for an authorization server" do
      VCR.use_cassette("list_authorization_server_policies") do
        resp, = client.list_authorization_server_policies(AUTH_SERVER_ID)
        expect(resp.map(&:id)).to(include(POLICY_ID))
      end
    end
  end

  describe "#add_authorization_server_policy" do
    it "creates a policy within an authorization server" do
      params = { "type" => "OAUTH_AUTHORIZATION_POLICY",
                 "status" => "ACTIVE",
                 "name" => "Default Policy",
                 "description" => "Default policy description",
                 "priority" => 1,
                 "conditions" => { "clients" => { "include" => ["ALL_CLIENTS"] } }, }

      VCR.use_cassette("add_authorization_server_policy") do
        resp, = client.add_authorization_server_policy(AUTH_SERVER_ID, params)
        expect(resp.id).to(be == POLICY_ID)
      end
    end
  end

  describe "#update_authorization_server" do
    it "updates an authorization server" do
      params = { "name" => "New Authorization Server",
                 "description" => "Authorization Server New Description",
                 "issuerMode" => "ORG_URL",
                 "audiences" => ["api://default"], }

      VCR.use_cassette("update_authorization_server") do
        resp, = client.update_authorization_server(AUTH_SERVER_ID, params)
        expect(resp.id).to(be == AUTH_SERVER_ID)
      end
    end
  end

  describe "#delete_authorization_server" do
    it "deletes the respective authorization server" do
      VCR.use_cassette("delete_authorization_server") do
        _, code = client.delete_authorization_server(AUTH_SERVER_ID)
        expect(code).to(eq(204))
      end
    end
  end

  describe "#update_authorization_server_policy" do
    it "updates a policy within an authorization server" do
      params = { "type" => "OAUTH_AUTHORIZATION_POLICY",
                 "id" => POLICY_ID,
                 "status" => "ACTIVE",
                 "name" => "default",
                 "description" => "default policy",
                 "priority" => 1,
                 "system" => false,
                 "conditions" => { "clients" => { "include" => ["ALL_CLIENTS"] } }, }

      VCR.use_cassette("update_authorization_server_policy") do
        resp, = client.update_authorization_server_policy(AUTH_SERVER_ID, POLICY_ID, params)
        expect(resp.id).to(be == POLICY_ID)
      end
    end
  end

  describe "#activate_authorization_server" do
    it "activates an authorization server" do
      VCR.use_cassette("activate_authorization_server") do
        _, code = client.activate_authorization_server(AUTH_SERVER_ID)
        expect(code).to(eq(204))
      end
    end
  end

  describe "#deactivate_authorization_server" do
    it "deactivates an authorization server" do
      VCR.use_cassette("deactivate_authorization_server") do
        _, code = client.deactivate_authorization_server(AUTH_SERVER_ID)
        expect(code).to(eq(204))
      end
    end
  end
end
