require 'spec_helper'

describe Oktakit::Client::AdminRoles do
  ADMIN_ROLES_GROUP_ID = '00g6nm9yt5VEl6xYd0h7'
  ADMIN_ROLES_USER_ID = '00u6nm9ytbmwHeunx0h7'
  ADMIN_ROLES_APP_NAME = 'googleappsadmin'

  describe '#list_roles_assigned_to_user' do
    it 'returns array of role' do
      VCR.use_cassette('list_roles_assigned_to_user') do
        resp, = client.list_roles_assigned_to_user(ADMIN_ROLES_USER_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#assign_role_to_user' do
    it 'returns assigned role' do
      VCR.use_cassette('assign_role_to_user') do
        resp, = client.assign_role_to_user(ADMIN_ROLES_USER_ID, type: 'SUPER_ADMIN')
        expected_hash = {
          id: "ra16nmck9rsYOQiqi0h7",
          label: "Super Organization Administrator",
          type: "SUPER_ADMIN",
          status: "ACTIVE",
          created: "2016-07-14T03:21:12.000Z",
          lastUpdated: "2016-07-14T03:21:12.000Z",
        }
        expect(resp.to_h).to(be == expected_hash)
      end
    end
  end

  describe '#unassign_role_from_user' do
    it 'returns http 204 no content' do
      VCR.use_cassette('unassign_role_from_user') do
        _, status = client.unassign_role_from_user(ADMIN_ROLES_USER_ID, 'ra16nmck9rsYOQiqi0h7')
        expect(status).to(be(204))
      end
    end
  end

  describe '#list_group_targets_for_user_admin_role' do
    it 'returns array of groups' do
      VCR.use_cassette('list_group_targets_for_user_admin_role') do
        resp, = client.list_group_targets_for_user_admin_role(ADMIN_ROLES_USER_ID, 'ra16nlr5esxo0o0TI0h7')
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#add_group_target_to_user_admin_role' do
    it 'returns http 204 no content' do
      VCR.use_cassette('add_group_target_to_user_admin_role') do
        _, status = client.add_group_target_to_user_admin_role(
          ADMIN_ROLES_USER_ID,
          'ra16nmg6csiUalQhH0h7',
          ADMIN_ROLES_GROUP_ID
        )
        expect(status).to(be(204))
      end
    end
  end

  describe '#remove_group_target_from_user_admin_role' do
    it 'returns http 204 no content' do
      VCR.use_cassette('remove_group_target_from_user_admin_role') do
        _, status = client.remove_group_target_from_user_admin_role(
          ADMIN_ROLES_USER_ID,
          'role_id',
          ADMIN_ROLES_GROUP_ID
        )
        expect(status).to(be(204))
      end
    end
  end

  describe '#list_app_targets_for_app_admin_role' do
    it 'returns array of catalog apps' do
      VCR.use_cassette('list_app_targets_for_app_admin_role') do
        resp, = client.list_app_targets_for_app_admin_role(ADMIN_ROLES_USER_ID, 'ra16nmg6csiUalQhH0h7')
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#add_app_target_to_app_admin_role' do
    it 'returns http 204 no content' do
      VCR.use_cassette('add_app_target_to_app_admin_role') do
        _, status = client.add_app_target_to_app_admin_role(
          ADMIN_ROLES_USER_ID,
          'ra16nmg6csiUalQhH0h7',
          ADMIN_ROLES_APP_NAME
        )
        expect(status).to(be(204))
      end
    end
  end

  describe '#remove_app_target_from_app_admin_role' do
    it 'returns http 204 no content' do
      VCR.use_cassette('remove_app_target_from_app_admin_role') do
        _, status = client.remove_app_target_from_app_admin_role(ADMIN_ROLES_USER_ID, 'role_id', ADMIN_ROLES_APP_NAME)
        expect(status).to(be(204))
      end
    end
  end
end
