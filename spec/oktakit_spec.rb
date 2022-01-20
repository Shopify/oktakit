require 'spec_helper'

describe Oktakit do
  it 'has a version number' do
    expect(Oktakit::VERSION).not_to(be(nil))
  end

  describe '.new' do
    it 'creates a client with the passed in keyword arguments' do
      client = Oktakit.new(token: test_okta_token, organization: 'okta-test')
      expect(client.api_endpoint).to(eq('https://okta-test.okta.com/api/v1'))
    end
  end

  describe 'client' do
    it 'has a default API endpoint' do
      client = Oktakit::Client.new(token: test_okta_token, organization: 'okta-test')
      expect(client.api_endpoint).to(eq('https://okta-test.okta.com/api/v1'))
    end

    it 'allows to configure the API endpoint' do
      client = Oktakit::Client.new(token: test_okta_token, api_endpoint: 'https://okta-test.oktapreview.com/api/v1')
      expect(client.api_endpoint).to(eq('https://okta-test.oktapreview.com/api/v1'))
    end

    it 'raises ArgumentError when no organization or api_endpoint is provided' do
      expect { Oktakit::Client.new(token: test_okta_token) }.to(raise_error(ArgumentError))
    end
  end

  ERROR_STATUSES = [
    400,
    401,
    403,
    404,
    405,
    406,
    409,
    415,
    422,
    418,
    500,
    501,
    502,
    503,
    504,
  ]

  describe 'errors' do
    ERROR_STATUSES.each do |error_status|
      it "returns a #{error_status} status for #{error_status} responses" do
        VCR.use_cassette(error_status) do
          _, response_status = client.get('/users/-1')
          expect(response_status).to eq(error_status)
        end
      end
    end
  end
end
