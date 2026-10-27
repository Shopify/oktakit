require "spec_helper"

describe "resource ID validation" do
  invalid_ids = [
    nil,
    123,
    "",
    ".",
    "..",
    "00uX/factors",
    "00uX/groups",
    "00uX/appLinks",
    "../groups",
    "00uX\\factors",
    "00uX?expand=credentials",
    "00uX#fragment",
    "00uX;x",
    "..;x",
    "00uX%2ffactors",
    "00uX%2Ffactors",
    "00uX%252Ffactors",
    "00uX%3Bx",
    "%2e%2e",
    "00uX\n",
    "00uX\0",
  ]
  resource_modules = Oktakit::Client.included_modules.select do |mod|
    mod.name.to_s.start_with?("Oktakit::Client::")
  end

  resource_modules.each do |resource|
    resource.instance_methods(false).sort.each do |method_name|
      id_params = resource.instance_method(method_name).parameters.select { |type, _| type == :req }
      next if id_params.empty?

      describe "##{method_name}" do
        id_params.each_with_index do |(_, param), index|
          invalid_ids.each do |id|
            it "rejects #{param}=#{id.inspect} before making a request" do
              args = Array.new(id_params.size, "00uValid")
              args[index] = id
              expect(client).not_to(receive(:request))

              expect { client.public_send(method_name, *args) }
                .to(raise_error(ArgumentError, "id must be a non-empty, safe URL path segment"))
            end
          end
        end

        it "accepts valid IDs" do
          expect(client).to(receive(:request).and_return([{}, 200]))

          client.public_send(method_name, *Array.new(id_params.size, "00uValid"))
        end
      end
    end
  end

  it "rejects an invalid partial-update ID before consuming options" do
    expect(client).not_to(receive(:request))

    expect { client.update_user("00uX;x", { partial: true }.freeze) }.to(raise_error(ArgumentError))
  end
end
