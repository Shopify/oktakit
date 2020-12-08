require 'spec_helper'

describe Oktakit::Client::IdentityProviders do
  IDENTITY_PROVIDERS_IDENTITY_ID = '0oa62bfdjnK55Z5x80h7'
  IDENTITY_PROVIDERS_TRANSACTION_ID = 'satvklBYyJmwa6qOg0g3'
  IDENTITY_PROVIDERS_KEY_ID = '74bb2164-e0c8-4457-862b-7c29ba6cd2c9'
  IDENTITY_PROVIDERS_USER_ID = '00u6o0w6tyuPVEeZr0h7'

  describe '#add_identity_provider' do
    it 'returns the created identity provider' do
      VCR.use_cassette('add_identity_provider', record: :new_episodes) do
        resp, = client.add_identity_provider(
          type: "SAML2",
          name: "Example IdP",
          protocol: {
            type: "SAML2",
            endpoints: {
              sso: {
                url: "https://idp.example.com",
                binding: "HTTP-POST",
                destination: "https://idp.example.com",
              },
              acs: {
                binding: "HTTP-POST",
                type: "INSTANCE",
              },
            },
            algorithms: {
              request: {
                signature: {
                  algorithm: "SHA-256",
                  scope: "REQUEST",
                },
              },
              response: {
                signature: {
                  algorithm: "SHA-256",
                  scope: "ANY",
                },
              },
            },
            credentials: {
              trust: {
                issuer: "https://idp.example.com",
                audience: "http://www.okta.com/123",
                kid: "74bb2164-e0c8-4457-862b-7c29ba6cd2c9",
              },
            },
          },
          policy: {
            provisioning: {
              action: "AUTO",
              profileMaster: true,
              groups: {
                action: "NONE",
              },
            },
            accountLink: {
              filter: nil,
              action: "AUTO",
            },
            subject: {
              userNameTemplate: {
                template: "saml.subjectNameId",
              },
              format: ["urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified"],
              filter: "(\\S+@example\\.com)",
              matchType: "USERNAME",
            },
          }
        )
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#get_identity_provider' do
    it 'returns identity provider' do
      VCR.use_cassette('get_identity_provider', record: :new_episodes) do
        resp, = client.get_identity_provider(IDENTITY_PROVIDERS_IDENTITY_ID)
        expect(resp.id).to(be == IDENTITY_PROVIDERS_IDENTITY_ID)
      end
    end
  end

  describe '#list_identity_providers' do
    it 'returns array of identity provider' do
      VCR.use_cassette('list_identity_providers', record: :new_episodes) do
        resp, = client.list_identity_providers
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#update_identity_provider' do
    it 'returns updated identity provider' do
      VCR.use_cassette('update_identity_provider', record: :new_episodes) do
        _, status = client.update_identity_provider(
          IDENTITY_PROVIDERS_IDENTITY_ID,
          id: "0oa62bfdjnK55Z5x80h7",
          type: "SAML2",
          name: "Example IdP",
          protocol: {
            type: "SAML2",
            endpoints: {
              sso: {
                url: "https://idp.example.com/saml2/sso",
                binding: "HTTP-REDIRECT",
                destination: "https://idp.example.com/saml2/sso",
              },
              acs: {
                binding: "HTTP-POST",
                type: "INSTANCE",
              },
            },
            algorithms: {
              request: {
                signature: {
                  algorithm: "SHA-256",
                  scope: "REQUEST",
                },
              },
              response: {
                signature: {
                  algorithm: "SHA-256",
                  scope: "ANY",
                },
              },
            },
            credentials: {
              trust: {
                issuer: "https://idp.example.com",
                audience: "https://www.okta.com/saml2/service-provider/spCQJRNaaxs7ANqKBO7M",
                kid: "74bb2164-e0c8-4457-862b-7c29ba6cd2c9",
              },
            },
          },
          policy: {
            provisioning: {
              action: "AUTO",
              profileMaster: true,
              groups: {
                action: "NONE",
              },
            },
            accountLink: {
              filter: nil,
              action: "AUTO",
            },
            subject: {
              userNameTemplate: {
                template: "idpuser.subjectNameId",
                type: "BUILT_IN",
              },
              format: [
                "urn:oasis:names:tc:SAML:1.1:nameid-format:unspecified",
              ],
              filter: nil,
              matchType: "USERNAME",
            },
            maxClockSkew: 120000,
          }
        )
        expect(status).to(be(200))
      end
    end
  end

  describe '#delete_identity_provider' do
    it 'returns http 204 no content' do
      VCR.use_cassette('delete_identity_provider', record: :new_episodes) do
        _, status = client.delete_identity_provider(IDENTITY_PROVIDERS_IDENTITY_ID)
        expect(status).to(be(204))
      end
    end
  end

  describe '#activate_identity_provider' do
    it 'returns activated identity provider' do
      VCR.use_cassette('activate_identity_provider', record: :new_episodes) do
        resp, = client.activate_identity_provider(IDENTITY_PROVIDERS_IDENTITY_ID)
        expect(resp.id).to(be == IDENTITY_PROVIDERS_IDENTITY_ID)
      end
    end
  end

  describe '#deactivate_identity_provider' do
    it 'returns deactivated identity provider' do
      VCR.use_cassette('deactivate_identity_provider', record: :new_episodes) do
        resp, = client.deactivate_identity_provider(IDENTITY_PROVIDERS_IDENTITY_ID)
        expect(resp.id).to(be == IDENTITY_PROVIDERS_IDENTITY_ID)
      end
    end
  end

  describe '#get_identity_provider_transaction' do
    it 'returns identity provider transaction' do
      VCR.use_cassette('get_identity_provider_transaction', record: :new_episodes) do
        resp, = client.get_identity_provider_transaction(IDENTITY_PROVIDERS_TRANSACTION_ID)
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#get_source_idp_user_for_idp_transaction' do
    it 'returns identity provider user' do
      VCR.use_cassette('get_source_idp_user_for_idp_transaction', record: :new_episodes) do
        resp, = client.get_source_idp_user_for_idp_transaction(IDENTITY_PROVIDERS_TRANSACTION_ID)
        expect(resp.externalId).not_to(be_nil)
      end
    end
  end

  describe '#get_target_user_for_idp_provision_transaction' do
    it 'returns trasformed okta user profile' do
      VCR.use_cassette('get_target_user_for_idp_provision_transaction', record: :new_episodes) do
        resp, = client.get_target_user_for_idp_provision_transaction(IDENTITY_PROVIDERS_TRANSACTION_ID)
        expect(resp.profile).not_to(be_nil)
      end
    end
  end

  describe '#list_users_for_idp_link_transaction' do
    it 'returns array of okta user' do
      VCR.use_cassette('list_users_for_idp_link_transaction', record: :new_episodes) do
        resp, = client.list_users_for_idp_link_transaction(IDENTITY_PROVIDERS_TRANSACTION_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#provision_idp_user' do
    it 'returns identity provider transaction' do
      VCR.use_cassette('provision_idp_user', record: :new_episodes) do
        resp, = client.provision_idp_user(IDENTITY_PROVIDERS_TRANSACTION_ID, profile: { userType: "Social" })
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#link_idp_user' do
    it 'returns identity provider transaction' do
      VCR.use_cassette('link_idp_user', record: :new_episodes) do
        resp, = client.link_idp_user(IDENTITY_PROVIDERS_TRANSACTION_ID, IDENTITY_PROVIDERS_USER_ID,
                                     profile: {
                                       userType: "Social",
                                     })
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#add_x509_certificate_public_key' do
    it 'returns identity provider key credential' do
      VCR.use_cassette('add_x509_certificate_public_key', record: :new_episodes) do
        resp, = client.add_x509_certificate_public_key
        expect(resp.kid).not_to(be_nil)
      end
    end
  end

  describe '#get_key' do
    it 'returns identity provider key credential' do
      VCR.use_cassette('get_key', record: :new_episodes) do
        resp, = client.get_key(IDENTITY_PROVIDERS_KEY_ID)
        expect(resp.kid).not_to(be_nil)
      end
    end
  end

  describe '#list_keys' do
    it 'returns array of identity provider key credential' do
      VCR.use_cassette('list_keys', record: :new_episodes) do
        resp, = client.list_keys
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#delete_key' do
    it 'returns http 204 no content' do
      VCR.use_cassette('delete_key', record: :new_episodes) do
        _, status = client.delete_key(IDENTITY_PROVIDERS_KEY_ID)
        expect(status).to(be(204))
      end
    end
  end
end
