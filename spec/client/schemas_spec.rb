require 'spec_helper'

describe Oktakit::Client::Schemas do
  SCHEMAS_SCHEMA_ID = 'https://okta-test.okta.com/meta/schemas/user/default'

  describe '#get_user_schema' do
    it 'returns user schema' do
      VCR.use_cassette('get_user_schema') do
        resp, = client.get_user_schema
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#add_property_to_user_profile_schema' do
    it 'returns user schema' do
      VCR.use_cassette('add_property_to_user_profile_schema') do
        resp, status = client.add_property_to_user_profile_schema(
          definitions: {
            custom: {
              id: "#custom",
              type: "object",
              properties: {
                twitterUserName: {
                  title: "Twitter username",
                  description: "User's username for twitter.com",
                  type: "string",
                  required: false,
                  minLength: 1,
                  maxLength: 20,
                  permissions: [
                    {
                      principal: "SELF",
                      action: "READ_WRITE",
                    },
                  ],
                },
              },
              required: [],
            },
          }
        )
        expect(resp.id).not_to(be_nil)
        expect(status).to(be(200))
      end
    end
  end

  describe '#update_user_profile_schema_property' do
    it 'returns user schema' do
      VCR.use_cassette('update_user_profile_schema_property') do
        resp, status = client.update_user_profile_schema_property(
          definitions: {
            custom: {
              id: "#custom",
              type: "object",
              properties: {
                twitterUserName: {
                  title: "Twitter username",
                  description: "User's username for twitter.com",
                  type: "string",
                  required: false,
                  minLength: 1,
                  maxLength: 10,
                  permissions: [
                    {
                      principal: "SELF",
                      action: "READ_ONLY",
                    },
                  ],
                },
              },
              required: [],
            },
          }
        )
        expect(resp.id).not_to(be_nil)
        expect(status).to(be(200))
      end
    end
  end

  describe '#remove_property_from_user_profile_schema' do
    it 'returns user schema' do
      VCR.use_cassette('remove_property_from_user_profile_schema') do
        _, status = client.remove_property_from_user_profile_schema(
          definitions: {
            custom: {
              id: "#custom",
              type: "object",
              properties: { twitterUserName: nil },
            },
          }
        )
        expect(status).to(be(200))
      end
    end
  end
end
