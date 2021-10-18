require 'spec_helper'

describe Oktakit::Client::GroupRules do
  GROUP_RULE_ID = '0prt3z9wdtNLNPdpL0x7'

  describe '#add_group_rule' do
    it 'returns the created group rule' do
      VCR.use_cassette('add_group_rule') do
        resp, = client.add_group_rule({
          name: "New Group Rule",
          type: "group_rule",
          conditions: {
            expression: {
              type: "urn:okta:expression:1.0",
              value: "user.title==\"Tester\"",
            },
          },
          actions: {
            assignUserToGroups: {
              groupIds: [
                "00gt3zbab0n2wn7ik0x7",
              ],
            }
          }
        })
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#get_group_rule' do
    it 'returns fetched group rule' do
      VCR.use_cassette('get_group_rule') do
        resp, = client.get_group_rule(GROUP_RULE_ID)
        expect(resp.id).to(be == GROUP_RULE_ID)
      end
    end
  end

  describe '#list_group_rules' do
    it 'returns array of group rules' do
      VCR.use_cassette('list_group_rules') do
        resp, = client.list_group_rules
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#update_group_rule' do
    it 'returns updated group rule' do
      VCR.use_cassette('update_group_rule') do
        resp, = client.update_group_rule(
          GROUP_RULE_ID,
          {
            name: "New Name for the Group Rule",
            type: "group_rule",
            conditions: {
              expression: {
                type: "urn:okta:expression:1.0",
                value: "user.title==\"Tester\"",
              },
            },
            actions: {
              assignUserToGroups: {
                groupIds: [
                  "00gt3zbab0n2wn7ik0x7",
                ],
              }
            }
          }
        )
        expect(resp.name).to(be == "New Name for the Group Rule")
      end
    end
  end

  describe '#remove_group_rule' do
    it 'returns http 202 accepted' do
      VCR.use_cassette('remove_group_rule') do
        _, status = client.remove_group_rule(GROUP_RULE_ID)
        expect(status).to(be(202))
      end
    end
  end

  describe '#activate_group_rule' do
    it 'returns http 204 no content' do
      VCR.use_cassette('activate_group_rule') do
        _, status = client.activate_group_rule(GROUP_RULE_ID)
        expect(status).to(be(204))
      end
    end
  end

  describe '#deactivate_group_rule' do
    it 'returns http 204 no content' do
      VCR.use_cassette('deactivate_group_rule') do
        _, status = client.deactivate_group_rule(GROUP_RULE_ID)
        expect(status).to(be(204))
      end
    end
  end
end
