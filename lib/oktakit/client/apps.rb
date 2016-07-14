module Oktakit
  class Client
    module Apps
      # Add Application
      #
      # @return [Hash<Sawyer::Resource>] All responses return the created Application.
      # @see http://developer.okta.com/docs/api/resources/apps.html#add-application
      # @example
      #   Oktakit.add_application
      def add_application(options = {})
        post('/apps', options)
      end

      # Get Application
      #
      # @return [Hash<Sawyer::Resource>] Fetched Application
      # @see http://developer.okta.com/docs/api/resources/apps.html#get-application
      # @example
      #   Oktakit.get_application('id')
      def get_application(id, options = {})
        get("/apps/#{id}", options)
      end

      # List Applications
      #
      # @return [Array<Sawyer::Resource>] Array of Applications
      # @see http://developer.okta.com/docs/api/resources/apps.html#list-applications
      # @example
      #   Oktakit.list_applications
      def list_applications(options = {})
        get('/apps', options)
      end

      # Update Application
      #
      # @return [Hash<Sawyer::Resource>] Updated Application
      # @see http://developer.okta.com/docs/api/resources/apps.html#update-application
      # @example
      #   Oktakit.update_application('id')
      def update_application(id, options = {})
        put("/apps/#{id}", options)
      end

      # Delete Application
      #
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see http://developer.okta.com/docs/api/resources/apps.html#delete-application
      # @example
      #   Oktakit.delete_application('id')
      def delete_application(id, options = {})
        delete("/apps/#{id}", options)
      end

      # Activate Application
      #
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see http://developer.okta.com/docs/api/resources/apps.html#activate-application
      # @example
      #   Oktakit.activate_application('id')
      def activate_application(id, options = {})
        post("/apps/#{id}/lifecycle/activate", options)
      end

      # Deactivate Application
      #
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see http://developer.okta.com/docs/api/resources/apps.html#deactivate-application
      # @example
      #   Oktakit.deactivate_application('id')
      def deactivate_application(id, options = {})
        post("/apps/#{id}/lifecycle/deactivate", options)
      end

      # Assign User to Application for SSO
      #
      # @return [Hash<Sawyer::Resource>] Application User
      # @see http://developer.okta.com/docs/api/resources/apps.html#assign-user-to-application-for-sso
      # @example
      #   Oktakit.assign_user_to_application_for_sso('app_id')
      def assign_user_to_application_for_sso(app_id, options = {})
        post("/apps/#{app_id}/users", options)
      end

      # Assign User to Application for SSO & Provisioning
      #
      # @return [Hash<Sawyer::Resource>] Application User with user profile mappings applied
      # @see http://developer.okta.com/docs/api/resources/apps.html#assign-user-to-application-for-sso--provisioning
      # @example
      #   Oktakit.assign_user_to_application_for_sso__provisioning('app_id')
      def assign_user_to_application_for_sso__provisioning(app_id, options = {})
        post("/apps/#{app_id}/users", options)
      end

      # Get Assigned User for Application
      #
      # @return [Hash<Sawyer::Resource>] Application User
      # @see http://developer.okta.com/docs/api/resources/apps.html#get-assigned-user-for-application
      # @example
      #   Oktakit.get_assigned_user_for_application('user_id', 'app_id')
      def get_assigned_user_for_application(user_id, app_id, options = {})
        get("/apps/#{app_id}/users/#{user_id}", options)
      end

      # List Users Assigned to Application
      #
      # @return [Array<Sawyer::Resource>] Array of Application Users
      # @see http://developer.okta.com/docs/api/resources/apps.html#list-users-assigned-to-application
      # @example
      #   Oktakit.list_users_assigned_to_application('app_id')
      def list_users_assigned_to_application(app_id, options = {})
        get("/apps/#{app_id}/users", options)
      end

      # Update Application Credentials for Assigned User
      #
      # @return [Hash<Sawyer::Resource>] Application User
      # @see http://developer.okta.com/docs/api/resources/apps.html#update-application-credentials-for-assigned-user
      # @example
      #   Oktakit.update_application_credentials_for_assigned_user('user_id', 'app_id')
      def update_application_credentials_for_assigned_user(user_id, app_id, options = {})
        post("/apps/#{app_id}/users/#{user_id}", options)
      end

      # Update Application Profile for Assigned User
      #
      # @return [Hash<Sawyer::Resource>] Application User with user profile mappings applied
      # @see http://developer.okta.com/docs/api/resources/apps.html#update-application-profile-for-assigned-user
      # @example
      #   Oktakit.update_application_profile_for_assigned_user('user_id', 'app_id')
      def update_application_profile_for_assigned_user(user_id, app_id, options = {})
        post("/apps/#{app_id}/users/#{user_id}", options)
      end

      # Remove User from Application
      #
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see http://developer.okta.com/docs/api/resources/apps.html#remove-user-from-application
      # @example
      #   Oktakit.remove_user_from_application('user_id', 'app_id')
      def remove_user_from_application(user_id, app_id, options = {})
        delete("/apps/#{app_id}/users/#{user_id}", options)
      end

      # Assign Group to Application
      #
      # @return [Hash<Sawyer::Resource>] All responses return the assigned Application Group.
      # @see http://developer.okta.com/docs/api/resources/apps.html#assign-group-to-application
      # @example
      #   Oktakit.assign_group_to_application('group_id', 'app_id')
      def assign_group_to_application(group_id, app_id, options = {})
        put("/apps/#{app_id}/groups/#{group_id}", options)
      end

      # Get Assigned Group for Application
      #
      # @return [Hash<Sawyer::Resource>] Fetched Application Group
      # @see http://developer.okta.com/docs/api/resources/apps.html#get-assigned-group-for-application
      # @example
      #   Oktakit.get_assigned_group_for_application('group_id', 'app_id')
      def get_assigned_group_for_application(group_id, app_id, options = {})
        get("/apps/#{app_id}/groups/#{group_id}", options)
      end

      # List Groups Assigned to Application
      #
      # @return [Array<Sawyer::Resource>] Array of Application Groups
      # @see http://developer.okta.com/docs/api/resources/apps.html#list-groups-assigned-to-application
      # @example
      #   Oktakit.list_groups_assigned_to_application('app_id')
      def list_groups_assigned_to_application(app_id, options = {})
        get("/apps/#{app_id}/groups", options)
      end

      # Remove Group from Application
      #
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see http://developer.okta.com/docs/api/resources/apps.html#remove-group-from-application
      # @example
      #   Oktakit.remove_group_from_application('group_id', 'app_id')
      def remove_group_from_application(group_id, app_id, options = {})
        delete("/apps/#{app_id}/groups/#{group_id}", options)
      end

      # Generate New Application Key Credential
      #
      # @return [Hash<Sawyer::Resource>] Return the generated Application Key Credential.
      # @see http://developer.okta.com/docs/api/resources/apps.html#generate-new-application-key-credential
      # @example
      #   Oktakit.generate_new_application_key_credential('app_id')
      def generate_new_application_key_credential(app_id, options = {})
        post("/apps/#{app_id}/credentials/keys/generate", options)
      end

      # List Key Credentials for Application
      #
      # @return [Array<Sawyer::Resource>] Array of Application Key Credential.
      # @see http://developer.okta.com/docs/api/resources/apps.html#list-key-credentials-for-application
      # @example
      #   Oktakit.list_key_credentials_for_application('app_id')
      def list_key_credentials_for_application(app_id, options = {})
        get("/apps/#{app_id}/credentials/keys", options)
      end

      # Get Key Credential for Application
      #
      # @return [Hash<Sawyer::Resource>] Application Key Credential.
      # @see http://developer.okta.com/docs/api/resources/apps.html#get-key-credential-for-application
      # @example
      #   Oktakit.get_key_credential_for_application('app_id', 'key_id')
      def get_key_credential_for_application(app_id, key_id, options = {})
        get("/apps/#{app_id}/credentials/keys/#{key_id}", options)
      end

      # Preview SAML metadata for Application
      #
      # @return [Hash<Sawyer::Resource>] SAML metadata in XML
      # @see http://developer.okta.com/docs/api/resources/apps.html#preview-saml-metadata-for-application
      # @example
      #   Oktakit.preview_saml_metadata_for_application('app_id')
      def preview_saml_metadata_for_application(app_id, options = {})
        get("/apps/#{app_id}/sso/saml/metadata", options)
      end
    end
  end
end
