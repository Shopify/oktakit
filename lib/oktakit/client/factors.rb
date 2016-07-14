module Oktakit
  class Client
    module Factors
      # Get Factor
      #
      # @return [Hash<Sawyer::Resource>] Factor
      # @see http://developer.okta.com/docs/api/resources/factors.html#get-factor
      # @example
      #   Oktakit.get_factor('user_id', 'factor_id')
      def get_factor(user_id, factor_id, options = {})
        get("/api/v1/users/#{user_id}/factors/#{factor_id}", options)
      end

      # List Enrolled Factors
      #
      # @return [Array<Sawyer::Resource>] Array of Factors
      # @see http://developer.okta.com/docs/api/resources/factors.html#list-enrolled-factors
      # @example
      #   Oktakit.list_enrolled_factors('user_id')
      def list_enrolled_factors(user_id, options = {})
        get("/api/v1/users/#{user_id}/factors", options)
      end

      # List Factors to Enroll
      #
      # @return [Array<Sawyer::Resource>] Array of Factors
      # @see http://developer.okta.com/docs/api/resources/factors.html#list-factors-to-enroll
      # @example
      #   Oktakit.list_factors_to_enroll('user_id')
      def list_factors_to_enroll(user_id, options = {})
        get("/api/v1/users/#{user_id}/factors/catalog", options)
      end

      # List Security Questions
      #
      # @return [Array<Sawyer::Resource>] Array of Questions
      # @see http://developer.okta.com/docs/api/resources/factors.html#list-security-questions
      # @example
      #   Oktakit.list_security_questions('user_id')
      def list_security_questions(user_id, options = {})
        get("/api/v1/users/#{user_id}/factors/questions", options)
      end

      # Enroll Factor
      #
      # @return [Hash<Sawyer::Resource>] All responses return the enrolled Factor with a status of either PENDING_ACTIVATION or ACTIVE.
      # @see http://developer.okta.com/docs/api/resources/factors.html#enroll-factor
      # @example
      #   Oktakit.enroll_factor('id')
      def enroll_factor(id, options = {})
        post("/api/v1/users/#{id}/factors", options)
      end

      # Activate Factor
      #
      # @return [Hash<Sawyer::Resource>] If the passcode is correct you will receive the Factor with an ACTIVE status.
      # @see http://developer.okta.com/docs/api/resources/factors.html#activate-factor
      # @example
      #   Oktakit.activate_factor('user_id', 'factor_id')
      def activate_factor(user_id, factor_id, options = {})
        post("/users/#{user_id}/factors/#{factor_id}/lifecycle/activate", options)
      end

      # Reset Factor
      #
      # @return  204 No Content
      # @see http://developer.okta.com/docs/api/resources/factors.html#reset-factor
      # @example
      #   Oktakit.reset_factor('user_id', 'factor_id')
      def reset_factor(user_id, factor_id, options = {})
        delete("/api/v1/users/#{user_id}/factors/#{factor_id}", options)
      end

      # Verify Security Question Factor
      #
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-security-question-factor
      # @example
      #   Oktakit.verify_security_question_factor('user_id', 'factor_id')
      def verify_security_question_factor(user_id, factor_id, options = {})
        post("/users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Verify SMS Factor
      #
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-sms-factor
      # @example
      #   Oktakit.verify_sms_factor('user_id', 'factor_id')
      def verify_sms_factor(user_id, factor_id, options = {})
        post("/users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Verify TOTP Factor
      #
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-totp-factor
      # @example
      #   Oktakit.verify_totp_factor('user_id', 'factor_id')
      def verify_totp_factor(user_id, factor_id, options = {})
        post("/users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Verify Push Factor
      #
      # @return [Hash<Sawyer::Resource>] Verification result (waiting, success, rejected, or timeout)
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-push-factor
      # @example
      #   Oktakit.verify_push_factor('user_id', 'factor_id')
      def verify_push_factor(user_id, factor_id, options = {})
        post("/users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Poll for Verify Transaction Completion
      #
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#poll-for-verify-transaction-completion
      # @example
      #   Oktakit.poll_for_verify_transaction_completion('user_id', 'factor_id', 'transaction_id')
      def poll_for_verify_transaction_completion(user_id, factor_id, transaction_id, options = {})
        get("/users/#{user_id}/factors/#{factor_id}/transactions/#{transaction_id}", options)
      end

      # Verify Token Factor
      #
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-token-factor
      # @example
      #   Oktakit.verify_token_factor('user_id', 'factor_id')
      def verify_token_factor(user_id, factor_id, options = {})
        post("/users/#{user_id}/factors/#{factor_id}/verify", options)
      end
    end
  end
end
