module Oktakit
  class Client
    # Methods for the Users API
    #
    # @see http://developer.okta.com/docs/api/resources/users.html
    module Users
      # List all users
      #
      # @return [Array<Sawyer::Resource>] Array of hashes representing Okta users.
      # @see http://developer.okta.com/docs/api/resources/users.html#list-all-users
      # @example
      #   Oktakit.users
      def users(options = {})
        get('/users', options)
      end

      # Get user
      #
      # @return [Array<Sawyer::Resource>] Hash representing the Okta user.
      # @see http://developer.okta.com/docs/api/resources/users.html#get-user-with-id
      # @see http://developer.okta.com/docs/api/resources/users.html#get-user-with-login
      # @see http://developer.okta.com/docs/api/resources/users.html#get-user-with-login-shortname
      # @example
      #   Oktakit.user('julian.nadeau')
      def user(user, options = {})
        get("/users/#{user}", options)
      end

      # Get current user
      #
      # @return [Array<Sawyer::Resource>] Hash representing the current Okta users.
      # @see http://developer.okta.com/docs/api/resources/users.html#get-current-user
      # @example
      #   Oktakit.current_user
      def current_user(options = {})
        get("/users/me", options)
      end

      # Create User
      #
      # @return [Array<Sawyer::Resource>] Hash representing an Okta User
      # @see http://developer.okta.com/docs/api/resources/users.html#create-user
      # @example
      #   Oktakit.create_user({})
      def create_user(options = {})
        post("/users", options)
      end

      # Update user
      #
      # @return [Array<Sawyer::Resource>] Hash representing an Okta User
      # @see http://developer.okta.com/docs/api/resources/users.html#update-user
      # @example
      #   Oktakit.update_user('jane.doe', {})
      def update_user(id, options = {})
        put("/users/#{id}", options)
      end

      # Update user profile
      #
      # @return [Array<Sawyer::Resource>] Hash representing an Okta User
      # @see http://developer.okta.com/docs/api/resources/users.html#update-profile
      # @example
      #   Oktakit.update_profile('john.doe', {})
      def update_profile(id, options = {})
        post("/users/#{id}", options)
      end

      # Get assigned app links
      #
      # @return [Array<Sawyer::Resource>] Hashes representing the app links
      # @see http://developer.okta.com/docs/api/resources/users.html#get-assigned-app-links
      # @example
      #   Oktakit.user_app_links('john.doe', {})
      def user_app_links(id, options = {})
        get("/users/#{id}/appLinks", options)
      end

      # Get member groups
      #
      # @return [Array<Sawyer::Resource>] Hashes representing the groups
      # @see http://developer.okta.com/docs/api/resources/users.html#get-member-groups
      # @example
      #   Oktakit.user_member_groups('jane.doe', {})
      def user_member_groups(id, options = {})
        get("/users/#{id}/groups", options)
      end

      # Activate user
      #
      # @return [Array<Sawyer::Resource>] HTTP 200 OK
      # @see http://developer.okta.com/docs/api/resources/users.html#activate-user
      # @example
      #   Oktakit.activate_user('john.doe', {})
      def activate_user(id, options = {})
        post("/users/#{id}/lifecycle/activate", options)
      end

      # Deactivate user
      #
      # @return [Array<Sawyer::Resource>] HTTP 200 OK
      # @see http://developer.okta.com/docs/api/resources/users.html#deactivate-user
      # @example
      #   Oktakit.deactive_user('jane.doe', {})
      def deactivate_user(id, options = {})
        post("/users/#{id}/lifecycle/deactivate", options)
      end

      # Suspend user
      #
      # @return [Array<Sawyer::Resource>] HTTP 200 OK
      # @see http://developer.okta.com/docs/api/resources/users.html#suspend-user
      # @example
      #   Oktakit.suspend_user('john.doe', {})
      def suspend_user(id, options = {})
        post("/users/#{id}/lifecycle/suspend", options)
      end

      # Unsuspend user
      #
      # @return [Array<Sawyer::Resource>] HTTP 200 OK
      # @see http://developer.okta.com/docs/api/resources/users.html#unsuspend-user
      # @example
      #   Oktakit.unsuspend_user('jane.doe', {})
      def unsuspend_user(id, options = {})
        post("/users/#{id}/lifecycle/unsuspend", options)
      end

      # Unlock a user
      #
      # @return [Array<Sawyer::Resource>] HTTP 200 OK
      # @see http://developer.okta.com/docs/api/resources/users.html#unlock-user
      # @example
      #   Oktakit.unlock_user('john.doe', {})
      def unlock_user(id, options = {})
        post("/users/#{id}/lifecycle/unlock", options)
      end

      # Reset a user's password
      #
      # @return [Array<Sawyer::Resource>] Hash with a url for a reset link
      # @see http://developer.okta.com/docs/api/resources/users.html#reset-password
      # @example
      #   Oktakit.reset_user_password('jane.doe', {})
      def reset_user_password(id, options = {})
        post("/users/#{id}/lifecycle/reset_password", options)
      end

      # Expire a user's password
      #
      # @return [Array<Sawyer::Resource>] Hash with a temporary password
      # @see http://developer.okta.com/docs/api/resources/users.html#expire-password
      # @example
      #   Oktakit.expire_user_password('john.doe', {})
      def expire_user_password(id, options = {})
        post("/users/#{id}/lifecycle/expire_password", options)
      end

      # Reset user MFA factors
      #
      # @return [Array<Sawyer::Resource>] HTTP 200 OK
      # @see http://developer.okta.com/docs/api/resources/users.html#reset-factors
      # @example
      #   Oktakit.reset_users_factors('jane.doe', {})
      def reset_users_factors(id, options = {})
        post("/users/#{id}/lifecycle/reset_factors", options)
      end

      # Get a password reset URL for a user
      #
      # @return [Array<Sawyer::Resource>] Hash with password reset url
      # @see http://developer.okta.com/docs/api/resources/users.html#forgot-password
      # @example
      #   Oktakit.user_forgot_password('john.doe', {})
      def user_forgot_password(id, options = {})
        post("/users/#{id}/credentials/forgot_password", options)
      end

      # Change a user's password
      #
      # @return [Array<Sawyer::Resource>] Hash representing an Okta User's Credentials
      # @see http://developer.okta.com/docs/api/resources/users.html#change-password
      # @example
      #   Oktakit.user_change_password('jane.doe', {})
      def user_change_password(id, options = {})
        post("/users/#{id}/credentials/change_password", options)
      end

      # Change a user's recovery question
      #
      # @return [Array<Sawyer::Resource>] Hash representing an Okta User
      # @see http://developer.okta.com/docs/api/resources/users.html#change-recovery-question
      # @example
      #   Oktakit.user_change_recovery_question('john.doe', {})
      def user_change_recovery_question(id, options = {})
        post("/users/#{id}/credentials/change_recovery_question", options)
      end
    end
  end
end
