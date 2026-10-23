require "spec_helper"

describe "resource ID path encoding" do
  # Captures the URL Faraday is about to send, using Faraday's built-in test
  # adapter instead of the network. VCR is turned off so no cassette is consulted.
  def requested_path(&block)
    seen = nil
    stubs = Faraday::Adapter::Test::Stubs.new
    [:get, :post, :put, :delete].each do |verb|
      stubs.public_send(verb, /.*/) do |env|
        seen = env.url.request_uri
        [200, { "Content-Type" => "application/json" }, "{}"]
      end
    end
    connection = Faraday.new do |builder|
      builder.use(Oktakit::Response::RaiseError)
      builder.adapter(:test, stubs)
    end
    allow(client).to(receive(:sawyer_options).and_return(
      links_parser: Sawyer::LinkParsers::Simple.new,
      faraday: connection,
    ))

    VCR.turned_off { block.call(client) }
    seen
  end

  describe "#get_user" do
    it "keeps a slash in the ID inside the user segment" do
      path = requested_path { |c| c.get_user("00uX/factors") }

      expect(path).not_to(eq("/api/v1/users/00uX/factors"))
      expect(path).to(eq("/api/v1/users/00uX%2Ffactors"))
    end
  end
end
