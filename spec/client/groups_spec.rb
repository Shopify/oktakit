require 'spec_helper'

describe Oktakit::Client::Groups do
  GROUPS_GROUP_ID = '00g6o0uh8xcL5WbyZ0h7'
  GROUPS_USER_ID  = '00u6nm9ytbmwHeunx0h7'
  let(:group_rule_id) { '0prnztlu4bzSqZ2vG0h7' }

  describe '#add_group' do
    it 'returns the created group.' do
      VCR.use_cassette 'add_group' do
        resp, = client.add_group(
          profile: {
            name:        "New Group Users",
            description: "New Group Users"
          }
        )
        expect(resp.id).not_to be_nil
      end
    end
  end

  describe '#get_group' do
    it 'returns fetched group' do
      VCR.use_cassette 'get_group' do
        resp, = client.get_group(GROUPS_GROUP_ID)
        expect(resp.id).to be == GROUPS_GROUP_ID
      end
    end
  end

  describe '#list_groups' do
    it 'returns array of groups' do
      VCR.use_cassette 'list_groups' do
        resp, = client.list_groups
        expect(resp).to be_a(Array)
      end
    end
  end

  describe '#update_group' do
    it 'returns updated group' do
      VCR.use_cassette 'update_group' do
        resp, = client.update_group(GROUPS_GROUP_ID,
                                    profile: {
                                      name:        "New Name for the Group",
                                      description: "New Name for the Group"
                                    })
        expect(resp.profile.name).to be == "New Name for the Group"
      end
    end
  end

  describe '#remove_group' do
    it 'returns http 204 no content' do
      VCR.use_cassette 'remove_group' do
        _, status = client.remove_group(GROUPS_GROUP_ID)
        expect(status).to be(204)
      end
    end
  end

  describe '#list_group_members' do
    it 'returns array of users' do
      VCR.use_cassette 'list_group_members' do
        resp, = client.list_group_members(GROUPS_GROUP_ID)
        expect(resp).to be_a(Array)
      end
    end
  end

  describe '#add_user_to_group' do
    it 'returns http 204 no content' do
      VCR.use_cassette 'add_user_to_group' do
        _, status = client.add_user_to_group(GROUPS_GROUP_ID, GROUPS_USER_ID)
        expect(status).to be(204)
      end
    end
  end

  describe '#remove_user_from_group' do
    it 'returns http 204 no content' do
      VCR.use_cassette 'remove_user_from_group' do
        _, status = client.remove_user_from_group(GROUPS_GROUP_ID, GROUPS_USER_ID)
        expect(status).to be(204)
      end
    end
  end

  describe '#list_assigned_applications' do
    it 'returns array of applications' do
      VCR.use_cassette 'list_assigned_applications' do
        resp, = client.list_assigned_applications(GROUPS_GROUP_ID)
        expect(resp).to be_a(Array)
      end
    end
  end

  describe '#add_group_rule' do
    let(:member_of_group_id) { '00gj57nf29Hb16yys0h7' }
    let(:group_ids_to_assign) { ['00gnztfrp0uIKGEf80h7'] }

    it 'returns the create group rule' do
      VCR.use_cassette 'add_group_rule' do
        resp, = client.add_group_rule(
          name:       'New Group Rule',
          type:       'group_rule',
          conditions: {
            expression: {
              type:  'urn:okta:expression:1.0',
              value: "isMemberOfAnyGroup(\"#{member_of_group_id}\")"
            }
          },
          actions:    {
            assignUserToGroups: {
              groupIds: group_ids_to_assign
            }
          })

        expect(resp.id).not_to be_nil
      end
    end
  end

  describe '#update_group_rule' do
    let(:member_of_group_id) { '00gj57nf29Hb16yys0h7' }
    let(:group_ids_to_assign) { ['00gnztfrp0uIKGEf80h7'] }

    it 'returns the updated group rule' do
      VCR.use_cassette 'update_group_rule' do
        resp, = client.update_group_rule(group_rule_id,
                                         name:       'A New Group Rule',
                                         type:       'group_rule',
                                         conditions: {
                                           expression: {
                                             type:  'urn:okta:expression:1.0',
                                             value: "isMemberOfAnyGroup(\"#{member_of_group_id}\")"
                                           }
                                         },
                                         actions:    {
                                           assignUserToGroups: {
                                             groupIds: group_ids_to_assign
                                           }
                                         })

        expect(resp.id).not_to be_nil
      end
    end
  end

  describe '#list_group_rules' do
    it 'returns an array of group rules' do
      VCR.use_cassette 'list_group_rules' do
        resp, = client.list_group_rules
        expect(resp).to be_a(Array)
      end
    end
  end

  describe '#get_group_rule' do
    it 'returns a group rule' do
      VCR.use_cassette 'get_group_rule' do
        resp, = client.get_group_rule(group_rule_id)
        expect(resp.id).not_to be_nil
      end
    end
  end

  describe '#activate_group_rule' do
    it 'activates a group rule' do
      VCR.use_cassette 'activate_group_rule' do
        _, status = client.activate_group_rule(group_rule_id)
        expect(status).to eq(204)
      end
    end
  end

  describe '#deactivate_group_rule' do
    it 'deactivates a group rule' do
      VCR.use_cassette 'deactivate_group_rule' do
        _, status = client.deactivate_group_rule(group_rule_id)
        expect(status).to eq(204)
      end
    end
  end

  describe '#delete_group_rule' do
    it 'deletes the group rule' do
      VCR.use_cassette 'delete_group_rule' do
        _, status = client.delete_group_rule(group_rule_id)
        expect(status).to eq(202)
      end
    end
  end
end
