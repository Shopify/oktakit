require "spec_helper"

describe "Oktakit::Client organization" do
  def host_for(organization)
    client = Oktakit::Client.new(token: "t", organization: organization)
    client.send(:sawyer_agent).instance_variable_get(:@conn).url_prefix.host
  end

  {
    "okta-test" => "okta-test.okta.com",
    "MyOrg" => "myorg.okta.com",
    "a" => "a.okta.com",
    "org123" => "org123.okta.com",
    "a" * 63 => "#{"a" * 63}.okta.com",
    :"my-org-symbol" => "my-org-symbol.okta.com",
  }.each do |organization, host|
    it "sends requests for #{organization.inspect} to #{host}" do
      expect(host_for(organization)).to(eq(host))
    end
  end

  [
    "evil.example#",
    "evil.example/x?",
    "evil.example",
    "user@evil.example",
    "evil.example:443",
    "my org",
    "-org",
    "org-",
    "org\n",
    "",
    "a" * 64,
  ].each do |organization|
    it "rejects #{organization.inspect} so the token cannot be sent to another host" do
      expect { Oktakit::Client.new(token: "t", organization: organization) }
        .to(raise_error(ArgumentError, /Invalid organization/))
    end
  end

  it "ignores the organization when api_endpoint is given" do
    client = Oktakit::Client.new(
      token: "t",
      organization: "not.a.label",
      api_endpoint: "https://my-org.oktapreview.com/api/v1",
    )

    expect(client.api_endpoint).to(eq("https://my-org.oktapreview.com/api/v1"))
  end
end
