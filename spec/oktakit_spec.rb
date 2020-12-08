require 'spec_helper'

describe Oktakit do
  it 'has a version number' do
    expect(Oktakit::VERSION).not_to(be(nil))
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

  ERRORS = {
    400 => Oktakit::BadRequest,
    401 => Oktakit::Unauthorized,
    403 => Oktakit::Forbidden,
    404 => Oktakit::NotFound,
    405 => Oktakit::MethodNotAllowed,
    406 => Oktakit::NotAcceptable,
    409 => Oktakit::Conflict,
    415 => Oktakit::UnsupportedMediaType,
    422 => Oktakit::UnprocessableEntity,
    418 => Oktakit::ClientError,
    500 => Oktakit::InternalServerError,
    501 => Oktakit::NotImplemented,
    502 => Oktakit::BadGateway,
    503 => Oktakit::ServiceUnavailable,
    504 => Oktakit::ServerError,
  }

  describe 'errors' do
    ERRORS.each do |code, error|
      it "raises a #{error} on #{code} responses" do
        VCR.use_cassette(code) do
          expect { client.get('/users/-1') }.to(raise_error(error))
        end
      end
    end
  end
end
