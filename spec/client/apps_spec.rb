require 'spec_helper'

describe Oktakit::Client::Apps do
  APPS_APP_ID = '0oa6nmg6fdvwvoHwR0h7'
  APPS_USER_ID = '00u6nm9ytbmwHeunx0h7'
  APPS_GROUP_ID = '00g6nm9yt5VEl6xYd0h7'

  describe '#add_application' do
    it 'returns all responses return the created application.' do
      # rubocop:disable Metrics/LineLength
      params = { "name" => "template_saml_2_0", "label" => "Example SAML App", "signOnMode" => "SAML_2_0", "settings" => { "app" => { "audienceRestriction" => "https://example.com/tenant/123", "forceAuthn" => false, "postBackURL" => "https://example.com/sso/saml", "authnContextClassRef" => "urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport", "requestCompressed" => "COMPRESSED", "recipient" => "https://example.com/sso/saml", "signAssertion" => "SIGNED", "destination" => "https://example.com/sso/saml", "signResponse" => "SIGNED", "nameIDFormat" => "urn:oasis:names:tc:SAML:1.1:nameid-format:emailAddress", "groupName" => nil, "groupFilter" => nil, "defaultRelayState" => nil, "configuredIssuer" => nil, "attributeStatements" => nil } } }
      # rubocop:enable Metrics/LineLength

      VCR.use_cassette('add_application') do
        resp, = client.add_application(params)
        expect(resp.id).to(be == APPS_APP_ID)
      end
    end
  end

  describe '#get_application' do
    it 'returns fetched application' do
      VCR.use_cassette('get_application') do
        resp, = client.get_application(APPS_APP_ID)
        expect(resp.id).to(be == APPS_APP_ID)
      end
    end
  end

  describe '#list_applications' do
    it 'returns array of applications' do
      VCR.use_cassette('list_applications') do
        resp, = client.list_applications
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#update_application' do
    it 'returns updated application' do
      VCR.use_cassette('update_application', record: :new_episodes) do
        resp, = client.update_application(APPS_APP_ID,
                                          id: APPS_APP_ID,
                                          signOnMode: "SAML_2_0")
        expect(resp.id).to(be == APPS_APP_ID)
      end
    end
  end

  describe '#delete_application' do
    it 'returns an empty json object {}' do
      VCR.use_cassette('delete_application', record: :new_episodes) do
        resp, status = client.delete_application(APPS_APP_ID)
        expect(status).to(be(204))
        expect(resp).to(be == "")
      end
    end
  end

  describe '#activate_application' do
    it 'returns an empty json object {}' do
      VCR.use_cassette('activate_application') do
        resp, status = client.activate_application(APPS_APP_ID)
        expect(status).to(be(200))
        expect(resp.to_h).to(be == {})
      end
    end
  end

  describe '#deactivate_application' do
    it 'returns an empty json object {}' do
      VCR.use_cassette('deactivate_application') do
        resp, status = client.deactivate_application(APPS_APP_ID)
        expect(status).to(be(200))
        expect(resp.to_h).to(be == {})
      end
    end
  end

  describe '#assign_user_to_application_for_sso' do
    it 'returns application user' do
      VCR.use_cassette('assign_user_to_application_for_sso') do
        resp, status = client.assign_user_to_application_for_sso(APPS_APP_ID,
                                                                 id: APPS_USER_ID,
                                                                 scope: "USER",
                                                                 credentials: {
                                                                   userName: "user@example.com",
                                                                 })
        expect(status).to(be(200))
        expect(resp.id).to(be == '00u6nm9ytbmwHeunx0h7')
      end
    end
  end

  describe '#assign_user_to_application_for_sso_provisioning' do
    it 'returns application user with user profile mappings applied' do
      VCR.use_cassette('assign_user_to_application_for_sso_provisioning', record: :new_episodes) do
        resp, status = client.assign_user_to_application_for_sso_provisioning(
          APPS_APP_ID,
          id: APPS_USER_ID,
          scope: "USER",
          credentials: { userName: "user@example.com" },
          profile: {}
        )
        expect(status).to(be(200))
        expect(resp.id).to(be == '00u6nm9ytbmwHeunx0h7')
      end
    end
  end

  describe '#get_assigned_user_for_application' do
    it 'returns application user' do
      VCR.use_cassette('get_assigned_user_for_application') do
        resp, = client.get_assigned_user_for_application(APPS_APP_ID, APPS_USER_ID)
        expect(resp.id).to(be == '00u6nm9ytbmwHeunx0h7')
      end
    end
  end

  describe '#list_users_assigned_to_application' do
    it 'returns array of application users' do
      VCR.use_cassette('list_users_assigned_to_application', record: :new_episodes) do
        resp, = client.list_users_assigned_to_application(APPS_APP_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#update_application_credentials_for_assigned_user' do
    it 'returns application user' do
      VCR.use_cassette('update_application_credentials_for_assigned_user', record: :new_episodes) do
        resp, = client.update_application_credentials_for_assigned_user(APPS_APP_ID, APPS_USER_ID,
                                                                        credentials: {
                                                                          userName: "user@example.com",
                                                                          password: {
                                                                            value: "newPassword",
                                                                          },
                                                                        })
        expect(resp.id).to(be == '00u6nm9ytbmwHeunx0h7')
      end
    end
  end

  describe '#update_application_profile_for_assigned_user' do
    it 'returns application user with user profile mappings applied' do
      VCR.use_cassette('update_application_profile_for_assigned_user', record: :new_episodes) do
        resp, = client.update_application_profile_for_assigned_user(APPS_APP_ID, APPS_USER_ID, profile: {})
        expect(resp.id).to(be == '00u6nm9ytbmwHeunx0h7')
      end
    end
  end

  describe '#remove_user_from_application' do
    it 'returns an empty json object {}' do
      VCR.use_cassette('remove_user_from_application', record: :new_episodes) do
        resp, status = client.remove_user_from_application(APPS_APP_ID, APPS_USER_ID)
        expect(status).to(be(204))
        expect(resp).to(be == "")
      end
    end
  end

  describe '#assign_group_to_application' do
    it 'returns all responses return the assigned application group.' do
      VCR.use_cassette('assign_group_to_application', record: :new_episodes) do
        resp, = client.assign_group_to_application(APPS_APP_ID, APPS_GROUP_ID)
        expect(resp.id).to(be == '00g6nm9yt5VEl6xYd0h7')
      end
    end
  end

  describe '#get_assigned_group_for_application' do
    it 'returns fetched application group' do
      VCR.use_cassette('get_assigned_group_for_application', record: :new_episodes) do
        resp, = client.get_assigned_group_for_application(APPS_APP_ID, APPS_GROUP_ID)
        expect(resp.id).to(be == '00g6nm9yt5VEl6xYd0h7')
      end
    end
  end

  describe '#list_groups_assigned_to_application' do
    it 'returns array of application groups' do
      VCR.use_cassette('list_groups_assigned_to_application', record: :new_episodes) do
        resp, = client.list_groups_assigned_to_application(APPS_APP_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#remove_group_from_application' do
    it 'returns an empty json object {}' do
      VCR.use_cassette('remove_group_from_application', record: :new_episodes) do
        resp, = client.remove_group_from_application(APPS_APP_ID, APPS_GROUP_ID)
        expect(resp).to(be == "")
      end
    end
  end

  describe '#generate_new_application_key_credential' do
    it 'returns return the generated application key credential.' do
      VCR.use_cassette('generate_new_application_key_credential', record: :new_episodes) do
        resp, = client.generate_new_application_key_credential(APPS_APP_ID, query: { validityYears: '1' })
        expect(resp.kid).to(be == 'akm5hvbbevE341ovl0h7')
      end
    end
  end

  describe '#list_key_credentials_for_application' do
    it 'returns array of application key credential.' do
      VCR.use_cassette('list_key_credentials_for_application', record: :new_episodes) do
        resp, = client.list_key_credentials_for_application(APPS_APP_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#get_key_credential_for_application' do
    it 'returns application key credential.' do
      VCR.use_cassette('get_key_credential_for_application', record: :new_episodes) do
        resp, = client.get_key_credential_for_application(APPS_APP_ID, 'akm5hvbbevE341ovl0h7')
        expect(resp.kid).to(be == 'akm5hvbbevE341ovl0h7')
      end
    end
  end

  describe '#preview_saml_metadata_for_application' do
    it 'returns saml metadata in xml' do
      VCR.use_cassette('preview_saml_metadata_for_application', record: :new_episodes) do
        resp, status = client.preview_saml_metadata_for_application(APPS_APP_ID, query: { q: 'akml95AVptFeCi4zm0g3' })
        expect(status).to(be(200))
        expect(resp).to(start_with('<?xml version="1.0" encoding="UTF-8"?>'))
      end
    end
  end
end
