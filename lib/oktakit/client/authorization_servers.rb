module Oktakit
  class Client
    module AuthorizationServers
      # Add Authorization Server
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] All responses return the created Authorization Server.
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#create-authorization-server
      # @example
      #   Oktakit.add_authorization_server
      def add_authorization_server(options = {})
        post('/authorizationServers', options)
      end

      # Get Authorization Server
      #
      # @params id [string] Authorization Server ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Fetched Authorization Server
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-authorization-server
      # @example
      #   Oktakit.get_authorization_server('id')
      def get_authorization_server(id, options = {})
        get("/authorizationServers/#{id}", options)
      end

      # List Authorization Servers
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Array of Authorization Servers
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#list-authorization-servers
      # @example
      #   Oktakit.list_authorization_servers
      def list_authorization_servers(options = {})
        get("/authorizationServers", options)
      end

      # List Authorization Server Policies
      #
      # @params id [string] Authorization Server ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Array of Authorization Server Policies
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#get-all-policies
      # @example
      #   Oktakit.list_authorization_server_policies('id')
      def list_authorization_server_policies(id, options = {})
        get("/authorizationServers/#{id}/policies", options)
      end

      # Update Authorization Server
      #
      # @params id [string] Authorization Server ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Updated Authorization Server
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#update-authorization-server
      # @example
      #   Oktakit.update_authorization_server('id')
      def update_authorization_server(id, options = {})
        put("/authorizationServers/#{id}", options)
      end

      # Update Authorization Server Policy
      #
      # @params id [string] Authorization Server ID
      # @params policy_id [string] Authorization Server Policy ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Updated Authorization Server Policy
      # @see http://developer.okta.com/docs/api/resources/apps.html#get-application
      # @example
      #   Oktakit.update_authorization_server_policy('id', 'policy_id')
      def update_authorization_server_policy(id, policy_id, options = {})
        put("/authorizationServers/#{id}/policies/#{policy_id}", options)
      end

      # Delete Authorization Server
      #
      # @params id [string] Authorization Server ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#delete-authorization-server
      # @example
      #   Oktakit.delete_authorization_server('id)
      def delete_authorization_server(id, options = {})
        delete("/authorizationServers/#{id}", options)
      end
      
      # Activate Authorization Server
      #
      # @params id [string] Authorization Server ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#activate-authorization-server
      # @example
      #   Oktakit.activate_authorization_server('id')
      def activate_authorization_server(id, options = {})
        post("/authorizationServers/#{id}/lifecycle/activate")
      end
      
      # Deactivate Authorization Server
      #
      # @params id [string] Authorization Server ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] An empty JSON object {}
      # @see https://developer.okta.com/docs/reference/api/authorization-servers/#deactivate-authorization-server
      # @example
      #   Oktakit.deactivate_authorization_server('id')
      def deactivate_authorization_server(id, options = {})
        post("/authorizationServers/#{id}/lifecycle/deactivate")
      end
    end
  end
end
