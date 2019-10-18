module Oktakit
  class Client
    module Users
      # Create User
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns the created User.
      # @see https://developer.okta.com/docs/api/resources/users#create-user
      # @example
      #   Oktakit.create_user
      def create_user(options = {})
        post('/users', options)
      end

      # Get User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Fetched User
      # @see https://developer.okta.com/docs/api/resources/users#get-user
      # @example
      #   Oktakit.get_user('id')
      def get_user(id, options = {})
        get("/users/#{id}", options)
      end

      # List Users
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of User
      # @see https://developer.okta.com/docs/api/resources/users#list-users
      # @example
      #   Oktakit.list_users
      def list_users(options = {})
        get('/users', options)
      end

      # Update User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options[:partial] [Boolean] Indicates a partial update, in which case POST will be used instead of PUT
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Updated User
      # @see https://developer.okta.com/docs/api/resources/users#update-user
      # @example
      #   Oktakit.update_user('id')
      def update_user(id, options = {})
        if options.delete(:partial)
          post("/users/#{id}", options)
        else
          put("/users/#{id}", options)
        end
      end

      # Update Profile
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Updated User
      # @see https://developer.okta.com/docs/api/resources/users#update-profile
      # @example
      #   Oktakit.update_profile('id')
      def update_profile(id, options = {})
        post("/users/#{id}", options)
      end

      # Get Assigned App Links
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of App Links
      # @see https://developer.okta.com/docs/api/resources/users#get-assigned-app-links
      # @example
      #   Oktakit.get_assigned_app_links('id')
      def get_assigned_app_links(id, options = {})
        get("/users/#{id}/appLinks", options)
      end

      # Get Member Groups
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of Groups
      # @see https://developer.okta.com/docs/api/resources/users#get-member-groups
      # @example
      #   Oktakit.get_member_groups('id')
      def get_member_groups(id, options = {})
        get("/users/#{id}/groups", options)
      end

      # Activate User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns empty object by default. If sendEmail is false, a user activation link.
      # @see https://developer.okta.com/docs/api/resources/users#activate-user
      # @example
      #   Oktakit.activate_user('id')
      def activate_user(id, options = {})
        post("/users/#{id}/lifecycle/activate", options)
      end

      # Reactivate User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns empty object by default. If sendEmail is false, a user activation link.
      # @see https://developer.okta.com/docs/api/resources/users#activate-user
      # @example
      #   Oktakit.activate_user('id')
      def reactivate_user(id, options = {})
        post("/users/#{id}/lifecycle/reactivate", options)
      end

      # Deactivate User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns an empty object.
      # @see https://developer.okta.com/docs/api/resources/users#deactivate-user
      # @example
      #   Oktakit.deactivate_user('id')
      def deactivate_user(id, options = {})
        post("/users/#{id}/lifecycle/deactivate", options)
      end

      # Suspend User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns an empty object.
      # @see https://developer.okta.com/docs/api/resources/users#suspend-user
      # @example
      #   Oktakit.suspend_user('id')
      def suspend_user(id, options = {})
        post("/users/#{id}/lifecycle/suspend", options)
      end

      # Unsuspend User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns an empty object. Returns an empty object.
      # @see https://developer.okta.com/docs/api/resources/users#unsuspend-user
      # @example
      #   Oktakit.unsuspend_user('id')
      def unsuspend_user(id, options = {})
        post("/users/#{id}/lifecycle/unsuspend", options)
      end

      # Unlock User
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns an empty object
      # @see http://developer.okta.com/docs/api/resources/users#unlock-user
      # @example
      #   Oktakit.unlock_user('id')
      def unlock_user(id, options = {})
        post("/users/#{id}/lifecycle/unlock", options)
      end

      # Reset Password
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns an empty object by default. If sendEmail is false a password reset link
      # @see https://developer.okta.com/docs/api/resources/users#reset-password
      # @example
      #   Oktakit.reset_password('id')
      def reset_password(id, options = {})
        post("/users/#{id}/lifecycle/reset_password", options)
      end

      # Expire Password
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns the user by default. If tempPassword is true, a temporary password.
      # @see https://developer.okta.com/docs/api/resources/users#expire-password
      # @example
      #   Oktakit.expire_password('id')
      def expire_password(id, options = {})
        post("/users/#{id}/lifecycle/expire_password", options)
      end

      # Reset Factors
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns an empty object by default.
      # @see https://developer.okta.com/docs/api/resources/users#reset-factors
      # @example
      #   Oktakit.reset_factors('id')
      def reset_factors(id, options = {})
        post("/users/#{id}/lifecycle/reset_factors", options)
      end

      # Forgot Password
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Returns an empty object by default. If sendEmail is false a password reset link
      # @see https://developer.okta.com/docs/api/resources/users#forgot-password
      # @example
      #   Oktakit.forgot_password('id')
      def forgot_password(id, options = {})
        post("/users/#{id}/credentials/forgot_password", options)
      end

      # Change Password
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Credentials of the user
      # @see https://developer.okta.com/docs/api/resources/users#change-password
      # @example
      #   Oktakit.change_password('id')
      def change_password(id, options = {})
        post("/users/#{id}/credentials/change_password", options)
      end

      # Change Recovery Question
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Credentials of the user
      # @see https://developer.okta.com/docs/api/resources/users#change-recovery-question
      # @example
      #   Oktakit.change_recovery_question('id')
      def change_recovery_question(id, options = {})
        post("/users/#{id}/credentials/change_recovery_question", options)
      end

      # Clear user sessions
      #
      # @params id [string] User ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for the request.
      # @return 204 'No Content'
      # @see https://developer.okta.com/docs/api/resources/users#user-sessions
      #   Oktakit.clear_user_sessions('id')
      def clear_user_sessions(id, options = {})
        delete("/users/#{id}/sessions", options)
      end
    end
  end
end
