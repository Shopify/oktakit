module Oktakit
  class Client
    module IdentityProviders
      # Add Identity Provider
      #
      # @return [Hash<Sawyer::Resource>] The created Identity Provider
      # @see http://developer.okta.com/docs/api/resources/idps.html#add-identity-provider
      # @example
      #   Oktakit.add_identity_provider
      def add_identity_provider(options = {})
        post('/idps', options)
      end

      # Get Identity Provider
      #
      # @return [Hash<Sawyer::Resource>] Identity Provider
      # @see http://developer.okta.com/docs/api/resources/idps.html#get-identity-provider
      # @example
      #   Oktakit.get_identity_provider('id')
      def get_identity_provider(id, options = {})
        get("/idps/#{id}", options)
      end

      # List Identity Providers
      #
      # @return [Array<Sawyer::Resource>] Array of Identity Provider
      # @see http://developer.okta.com/docs/api/resources/idps.html#list-identity-providers
      # @example
      #   Oktakit.list_identity_providers
      def list_identity_providers(options = {})
        get('/idps', options)
      end

      # Update Identity Provider
      #
      # @return [Hash<Sawyer::Resource>] Updated Identity Provider
      # @see http://developer.okta.com/docs/api/resources/idps.html#update-identity-provider
      # @example
      #   Oktakit.update_identity_provider('id')
      def update_identity_provider(id, options = {})
        put("/idps/#{id}", options)
      end

      # Delete Identity Provider
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/idps.html#delete-identity-provider
      # @example
      #   Oktakit.delete_identity_provider('id')
      def delete_identity_provider(id, options = {})
        delete("/idps/#{id}", options)
      end

      # Activate Identity Provider
      #
      # @return [Hash<Sawyer::Resource>] Activated Identity Provider
      # @see http://developer.okta.com/docs/api/resources/idps.html#activate-identity-provider
      # @example
      #   Oktakit.activate_identity_provider('id')
      def activate_identity_provider(id, options = {})
        post("/idps/#{id}/lifecycle/activate", options)
      end

      # Deactivate Identity Provider
      #
      # @return [Hash<Sawyer::Resource>] Deactivated Identity Provider
      # @see http://developer.okta.com/docs/api/resources/idps.html#deactivate-identity-provider
      # @example
      #   Oktakit.deactivate_identity_provider('id')
      def deactivate_identity_provider(id, options = {})
        post("/idps/#{id}/lifecycle/deactivate", options)
      end

      # Get Identity Provider Transaction
      #
      # @return [Hash<Sawyer::Resource>] Identity Provider Transaction
      # @see http://developer.okta.com/docs/api/resources/idps.html#get-identity-provider-transaction
      # @example
      #   Oktakit.get_identity_provider_transaction('transaction_id')
      def get_identity_provider_transaction(transaction_id, options = {})
        get("/idps/tx/#{transaction_id}", options)
      end

      # Get Source IdP User for IdP Transaction
      #
      # @return [Hash<Sawyer::Resource>] Identity Provider User
      # @see http://developer.okta.com/docs/api/resources/idps.html#get-source-idp-user-for-idp-transaction
      # @example
      #   Oktakit.get_source_idp_user_for_idp_transaction('transaction_id')
      def get_source_idp_user_for_idp_transaction(transaction_id, options = {})
        get("/idps/tx/#{transaction_id}/source", options)
      end

      # Get Target User for IdP Provision Transaction
      #
      # @return [Hash<Sawyer::Resource>] Trasformed Okta User Profile
      # @see http://developer.okta.com/docs/api/resources/idps.html#get-target-user-for-idp-provision-transaction
      # @example
      #   Oktakit.get_target_user_for_idp_provision_transaction('transaction_id')
      def get_target_user_for_idp_provision_transaction(transaction_id, options = {})
        get("/idps/tx/#{transaction_id}/target", options)
      end

      # List Users for IdP Link Transaction
      #
      # @return [Array<Sawyer::Resource>] Array of Okta User
      # @see http://developer.okta.com/docs/api/resources/idps.html#list-users-for-idp-link-transaction
      # @example
      #   Oktakit.list_users_for_idp_link_transaction('transaction_id')
      def list_users_for_idp_link_transaction(transaction_id, options = {})
        get("/idps/tx/#{transaction_id}/users", options)
      end

      # Provision IdP User
      #
      # @return [Hash<Sawyer::Resource>] Identity Provider Transaction
      # @see http://developer.okta.com/docs/api/resources/idps.html#provision-idp-user
      # @example
      #   Oktakit.provision_idp_user('transaction_id')
      def provision_idp_user(transaction_id, options = {})
        post("/idps/tx/#{transaction_id}/lifecycle/provision", options)
      end

      # Link IdP User
      #
      # @return [Hash<Sawyer::Resource>] Identity Provider Transaction
      # @see http://developer.okta.com/docs/api/resources/idps.html#link-idp-user
      # @example
      #   Oktakit.link_idp_user('user_id', 'transaction_id')
      def link_idp_user(user_id, transaction_id, options = {})
        post("/idps/tx/#{transaction_id}/lifecycle/confirm/#{user_id}", options)
      end

      # Add X.509 Certificate Public Key
      #
      # @return [Hash<Sawyer::Resource>] Identity Provider Key Credential
      # @see http://developer.okta.com/docs/api/resources/idps.html#add-x509-certificate-public-key
      # @example
      #   Oktakit.add_x509_certificate_public_key
      def add_x509_certificate_public_key(options = {})
        post('/idps/credentials/keys', options)
      end

      # Get Key
      #
      # @return [Hash<Sawyer::Resource>] Identity Provider Key Credential
      # @see http://developer.okta.com/docs/api/resources/idps.html#get-key
      # @example
      #   Oktakit.get_key('key_id')
      def get_key(key_id, options = {})
        get("/idps/credentials/keys/#{key_id}", options)
      end

      # List Keys
      #
      # @return [Array<Sawyer::Resource>] Array of Identity Provider Key Credential
      # @see http://developer.okta.com/docs/api/resources/idps.html#list-keys
      # @example
      #   Oktakit.list_keys
      def list_keys(options = {})
        get('/idps/credentials/keys', options)
      end

      # Delete Key
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/idps.html#delete-key
      # @example
      #   Oktakit.delete_key('key_id')
      def delete_key(key_id, options = {})
        delete("/idps/credentials/keys/#{key_id}", options)
      end
    end
  end
end
