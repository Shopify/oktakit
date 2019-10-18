require 'spec_helper'

describe Oktakit::Client::Users do
  USERS_USER_ID = '00u6o0w6tyuPVEeZr0h7'

  describe '#create_user' do
    it 'returns all responses return the created user.' do
      VCR.use_cassette 'create_user' do
        resp, = client.create_user(
          profile: {
            firstName: "Example",
            lastName: "User",
            email: "example@example.com",
            login: "example@example.com"
          },
          credentials: {
            password: { value: "MyPassword123!" },
            recovery_question: {
              question: "How much wood could a woodchuck chuck?",
              answer: "A woodchuck could chuck as much as he could chuck."
            }
          }
        )
        expect(resp.id).not_to be_nil
      end
    end
  end

  describe '#get_user' do
    it 'returns fetched user' do
      VCR.use_cassette 'get_user' do
        resp, = client.get_user(USERS_USER_ID)
        expect(resp.to_h).to have_key(:id)
        expect(resp.to_h).to have_key(:profile)
        %w[firstName lastName login email].each do |key|
          expect(resp.to_h[:profile].to_h).to have_key(key.to_sym)
        end
      end
    end
  end

  describe '#list_users' do
    it 'returns array of user' do
      VCR.use_cassette 'list_users' do
        resp, = client.list_users
        expect(resp).to be_a(Array)
      end
    end
  end

  describe '#update_user' do
    it 'returns updated user' do
      VCR.use_cassette 'update_user' do
        resp, = client.update_user(USERS_USER_ID,
                                   profile: {
                                     firstName: "Bob",
                                     lastName: "User",
                                     email: "example@example.com",
                                     login: "example@example.com"
                                   })
        expect(resp.profile.firstName).to be == 'Bob'
      end
    end
  end

  describe '#update_user partial' do
    it 'returns updated user' do
      VCR.use_cassette 'update_user_partial' do
        resp, = client.update_user(USERS_USER_ID,
                                   profile: {
                                     firstName: "Bob",
                                     lastName: "User",
                                     email: "example@example.com",
                                     login: "example@example.com"
                                   },
                                   partial: true)
        expect(resp.profile.firstName).to be == 'Bob'
      end
    end
  end

  describe '#update_profile' do
    it 'returns updated user' do
      VCR.use_cassette 'update_profile' do
        resp, = client.update_profile(USERS_USER_ID,
                                      profile: {
                                        firstName: "Other Bob",
                                        lastName: "User",
                                        email: "example@example.com",
                                        login: "example@example.com"
                                      })
        expect(resp.profile.firstName).to be == 'Other Bob'
      end
    end
  end

  describe '#get_assigned_app_links' do
    it 'returns array of app links' do
      VCR.use_cassette 'get_assigned_app_links' do
        resp, = client.get_assigned_app_links(USERS_USER_ID)
        expect(resp).to be_a(Array)
      end
    end
  end

  describe '#get_member_groups' do
    it 'returns array of groups' do
      VCR.use_cassette 'get_member_groups' do
        resp, = client.get_member_groups(USERS_USER_ID)
        expect(resp).to be_a(Array)
      end
    end
  end

  describe '#activate_user' do
    it 'returns empty object by default.' do
      VCR.use_cassette 'activate_user' do
        resp, = client.activate_user(USERS_USER_ID)
        expect(resp.to_h).to be == {}
      end
    end
  end

  describe '#reactivate_user' do
    it 'returns empty object by default.' do
      VCR.use_cassette 'reactivate_user' do
        resp, = client.reactivate_user(USERS_USER_ID)
        expect(resp.to_h).to be == {}
      end
    end
  end

  describe '#deactivate_user' do
    it 'returns an empty object.' do
      VCR.use_cassette 'deactivate_user' do
        resp, = client.deactivate_user(USERS_USER_ID)
        expect(resp.to_h).to be == {}
      end
    end
  end

  describe '#suspend_user' do
    it 'returns an empty object.' do
      VCR.use_cassette 'suspend_user' do
        resp, = client.suspend_user(USERS_USER_ID)
        expect(resp.to_h).to be == {}
      end
    end
  end

  describe '#unsuspend_user' do
    it 'returns an empty object. returns an empty object.' do
      VCR.use_cassette 'unsuspend_user' do
        resp, = client.unsuspend_user(USERS_USER_ID)
        expect(resp.to_h).to be == {}
      end
    end
  end

  describe '#unlock_user' do
    it 'returns an empty object' do
      VCR.use_cassette 'unlock_user' do
        _, status = client.unlock_user(USERS_USER_ID)
        expect(status).to be(200)
      end
    end
  end

  describe '#reset_password' do
    it 'returns an empty object by default.' do
      VCR.use_cassette 'reset_password' do
        resp, = client.reset_password(USERS_USER_ID)
        expect(resp.to_h).to be == {}
      end
    end
  end

  describe '#expire_password' do
    it 'returns the complete user object by default.' do
      VCR.use_cassette 'expire_password' do
        resp, = client.expire_password(USERS_USER_ID)
        expect(resp.status).to be == 'PASSWORD_EXPIRED'
      end
    end
  end

  describe '#reset_factors' do
    it 'returns an empty object by default.' do
      VCR.use_cassette 'reset_factors' do
        resp, = client.reset_factors(USERS_USER_ID)
        expect(resp.to_h).to be == {}
      end
    end
  end

  describe '#forgot_password' do
    it 'returns an empty object by default.' do
      VCR.use_cassette 'forgot_password' do
        resp, = client.forgot_password(
          USERS_USER_ID,
          password: { value: "123Password!" },
          recovery_question: { answer: "A woodchuck could chuck as much as he could chuck." }
        )
        expect(resp.password.to_h).to be == {}
      end
    end
  end

  describe '#change_password' do
    it 'returns credentials of the user' do
      VCR.use_cassette 'change_password' do
        _, status = client.change_password(USERS_USER_ID,
                                           oldPassword: { value: "uTVM,TPw55" },
                                           newPassword: { value: "NewPassword1234!" })
        expect(status).to be(200)
      end
    end
  end

  describe '#change_recovery_question' do
    it 'returns credentials of the user' do
      VCR.use_cassette 'change_recovery_question' do
        resp, = client.change_recovery_question(USERS_USER_ID,
                                                password: { value: "NewPassword1234!" },
                                                recovery_question: {
                                                  question: "Where is Shopify's HQ?",
                                                  answer: "Ottawa"
                                                })
        expect(resp.recovery_question.question).to be == "Where is Shopify's HQ?"
      end
    end
  end

  describe '#clear_user_sessions' do
    it 'returns 204 no content' do
      VCR.use_cassette 'clear_user_sessions' do
        _, status = client.clear_user_sessions(USERS_USER_ID)
        expect(status).to be(204)
      end
    end
  end
end
