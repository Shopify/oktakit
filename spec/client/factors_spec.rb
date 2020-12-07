require 'spec_helper'

describe Oktakit::Client::Factors do
  FACTORS_USER_ID = '00u6nm9ytbmwHeunx0h7'
  FACTORS_FACTOR_ID = 'mbl6o3uhd97Rc2PM70h7'
  FACTORS_TRANSACTION_ID = 'mbl6o3uhd97Rc2PM70h7'

  describe '#get_factor' do
    it 'returns factor' do
      VCR.use_cassette('get_factor', record: :new_episodes) do
        resp, = client.get_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(resp.id).to(be == FACTORS_FACTOR_ID)
      end
    end
  end

  describe '#list_enrolled_factors' do
    it 'returns array of factors' do
      VCR.use_cassette('list_enrolled_factors', record: :new_episodes) do
        resp, = client.list_enrolled_factors(FACTORS_USER_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#list_factors_to_enroll' do
    it 'returns array of factors' do
      VCR.use_cassette('list_factors_to_enroll', record: :new_episodes) do
        resp, = client.list_factors_to_enroll(FACTORS_USER_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#list_security_questions' do
    it 'returns array of questions' do
      VCR.use_cassette('list_security_questions', record: :new_episodes) do
        resp, = client.list_security_questions(FACTORS_USER_ID)
        expect(resp).to(be_a(Array))
      end
    end
  end

  describe '#enroll_factor' do
    it 'returns all responses return the enrolled factor with a status of either pending_activation or active.' do
      VCR.use_cassette('enroll_factor', record: :new_episodes) do
        resp, = client.enroll_factor(FACTORS_USER_ID,
                                     factorType: "sms",
                                     provider: "OKTA",
                                     profile: {
                                       phoneNumber: "+1-613-456-1234",
                                     })
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#activate_factor' do
    it 'returns if the passcode is correct you will receive the factor with an active status.' do
      VCR.use_cassette('activate_factor', record: :new_episodes) do
        resp, = client.activate_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(resp.id).not_to(be_nil)
      end
    end
  end

  describe '#reset_factor' do
    it 'returns 204 no content' do
      VCR.use_cassette('reset_factor', record: :new_episodes) do
        _, status = client.reset_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(status).to(be(204))
      end
    end
  end

  describe '#verify_security_question_factor' do
    it 'returns verification result' do
      VCR.use_cassette('verify_security_question_factor', record: :new_episodes) do
        resp, = client.verify_security_question_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(resp.factorResult).to(be == 'SUCCESS')
      end
    end
  end

  describe '#verify_sms_factor' do
    it 'returns verification result' do
      VCR.use_cassette('verify_sms_factor', record: :new_episodes) do
        resp, = client.verify_sms_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(resp.factorResult).to(be == 'SUCCESS')
      end
    end
  end

  describe '#verify_totp_factor' do
    it 'returns verification result' do
      VCR.use_cassette('verify_totp_factor', record: :new_episodes) do
        resp, = client.verify_totp_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(resp.factorResult).to(be == 'SUCCESS')
      end
    end
  end

  describe '#verify_push_factor' do
    it 'returns verification result (waiting, success, rejected, or timeout)' do
      VCR.use_cassette('verify_push_factor', record: :new_episodes) do
        resp, = client.verify_push_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(resp.factorResult).to(be == 'WAITING')
      end
    end
  end

  describe '#poll_for_verify_transaction_completion' do
    it 'returns verification result' do
      VCR.use_cassette('poll_for_verify_transaction_completion', record: :new_episodes) do
        resp, = client.poll_for_verify_transaction_completion(
          FACTORS_USER_ID,
          FACTORS_FACTOR_ID,
          FACTORS_TRANSACTION_ID
        )
        expect(resp.factorResult).to(be == 'WAITING')
      end
    end
  end

  describe '#verify_token_factor' do
    it 'returns verification result' do
      VCR.use_cassette('verify_token_factor', record: :new_episodes) do
        resp, = client.verify_token_factor(FACTORS_USER_ID, FACTORS_FACTOR_ID)
        expect(resp.factorResult).to(be == 'SUCCESS')
      end
    end
  end
end
