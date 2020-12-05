module Oktakit
  class Client
    module Factors
      # Get Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Factor
      # @see http://developer.okta.com/docs/api/resources/factors.html#get-factor
      # @example
      #   Oktakit.get_factor('user_id', 'factor_id')
      def get_factor(user_id, factor_id, options = {})
        get("users/#{user_id}/factors/#{factor_id}", options)
      end

      # List Enrolled Factors
      #
      # @params user_id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of Factors
      # @see http://developer.okta.com/docs/api/resources/factors.html#list-enrolled-factors
      # @example
      #   Oktakit.list_enrolled_factors('user_id')
      def list_enrolled_factors(user_id, options = {})
        get("users/#{user_id}/factors", options)
      end

      # List Factors to Enroll
      #
      # @params user_id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of Factors
      # @see http://developer.okta.com/docs/api/resources/factors.html#list-factors-to-enroll
      # @example
      #   Oktakit.list_factors_to_enroll('user_id')
      def list_factors_to_enroll(user_id, options = {})
        get("users/#{user_id}/factors/catalog", options)
      end

      # List Security Questions
      #
      # @params user_id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of Questions
      # @see http://developer.okta.com/docs/api/resources/factors.html#list-security-questions
      # @example
      #   Oktakit.list_security_questions('user_id')
      def list_security_questions(user_id, options = {})
        get("users/#{user_id}/factors/questions", options)
      end

      # Enroll Factor
      #
      # @params user_id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] The enrolled Factor with a status of either PENDING_ACTIVATION or ACTIVE.
      # @see http://developer.okta.com/docs/api/resources/factors.html#enroll-factor
      # @example
      #   Oktakit.enroll_factor('id')
      def enroll_factor(user_id, options = {})
        post("users/#{user_id}/factors", options)
      end

      # Activate Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] If the passcode is correct you will receive the Factor with an ACTIVE status.
      # @see http://developer.okta.com/docs/api/resources/factors.html#activate-factor
      # @example
      #   Oktakit.activate_factor('user_id', 'factor_id')
      def activate_factor(user_id, factor_id, options = {})
        post("users/#{user_id}/factors/#{factor_id}/lifecycle/activate", options)
      end

      # Reset Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return  204 No Content
      # @see http://developer.okta.com/docs/api/resources/factors.html#reset-factor
      # @example
      #   Oktakit.reset_factor('user_id', 'factor_id')
      def reset_factor(user_id, factor_id, options = {})
        delete("users/#{user_id}/factors/#{factor_id}", options)
      end

      # Verify Security Question Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-security-question-factor
      # @example
      #   Oktakit.verify_security_question_factor('user_id', 'factor_id')
      def verify_security_question_factor(user_id, factor_id, options = {})
        post("users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Verify SMS Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-sms-factor
      # @example
      #   Oktakit.verify_sms_factor('user_id', 'factor_id')
      def verify_sms_factor(user_id, factor_id, options = {})
        post("users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Verify TOTP Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-totp-factor
      # @example
      #   Oktakit.verify_totp_factor('user_id', 'factor_id')
      def verify_totp_factor(user_id, factor_id, options = {})
        post("users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Verify Push Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Verification result (waiting, success, rejected, or timeout)
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-push-factor
      # @example
      #   Oktakit.verify_push_factor('user_id', 'factor_id')
      def verify_push_factor(user_id, factor_id, options = {})
        post("users/#{user_id}/factors/#{factor_id}/verify", options)
      end

      # Poll for Verify Transaction Completion
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @params transaction_id [string] Transaction ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#poll-for-verify-transaction-completion
      # @example
      #   Oktakit.poll_for_verify_transaction_completion('user_id', 'factor_id', 'transaction_id')
      def poll_for_verify_transaction_completion(user_id, factor_id, transaction_id, options = {})
        get("users/#{user_id}/factors/#{factor_id}/transactions/#{transaction_id}", options)
      end

      # Verify Token Factor
      #
      # @params user_id [string] User ID
      # @params factor_id [string] Factor ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Verification result
      # @see http://developer.okta.com/docs/api/resources/factors.html#verify-token-factor
      # @example
      #   Oktakit.verify_token_factor('user_id', 'factor_id')
      def verify_token_factor(user_id, factor_id, options = {})
        post("users/#{user_id}/factors/#{factor_id}/verify", options)
      end
    end
  end
end
