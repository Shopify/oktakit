require "spec_helper"

describe "#list_applications_assigned_to_user" do
  let(:requests) { [] }

  before do
    stubs = Faraday::Adapter::Test::Stubs.new do |stub|
      stub.get("/api/v1/apps") do |env|
        requests << env
        [200, { "Content-Type" => "application/json" }, "[]"]
      end
    end
    connection = Faraday.new { |builder| builder.adapter(:test, stubs) }
    allow(client).to(receive(:sawyer_options).and_return(faraday: connection))
  end

  around do |example|
    VCR.turned_off { example.run }
  end

  [
    "00uValid",
    "00uX&limit=1",
    '00uX" or status eq "ACTIVE',
    "first.last+tag@example.com",
  ].each do |id|
    it "keeps #{id.inspect} inside the filter and expand values" do
      client.list_applications_assigned_to_user(id)

      expect(requests.size).to(eq(1))
      expect(requests.first.params).to(eq(
        "filter" => "user.id eq #{JSON.generate(id)}",
        "expand" => "user/#{id}",
      ))
    end
  end

  it "preserves other query options but overrides filter and expand without mutating the caller's options" do
    query = {
      limit: 5,
      filter: "wrong",
      "filter" => "also wrong",
      expand: "wrong",
      "expand" => "also wrong",
    }.freeze
    options = { query: query }.freeze

    client.list_applications_assigned_to_user("00uValid", options)

    expect(requests.first.params).to(eq(
      "limit" => "5",
      "filter" => 'user.id eq "00uValid"',
      "expand" => "user/00uValid",
    ))
  end
end
