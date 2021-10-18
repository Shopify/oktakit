module Oktakit
  class Client
    module GroupRules
      # Add Group Rule
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] The created Group Rule.
      # @see https://developer.okta.com/docs/reference/api/groups/#create-group-rule
      # @example
      #   Oktakit.add_group_rule
      def add_group_rule(options = {})
        post('/groups/rules', options)
      end

      # Get Group Rule
      #
      # @params id [string] Group Rule ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Fetched Group Rule
      # @see https://developer.okta.com/docs/reference/api/groups/#get-group-rule
      # @example
      #   Oktakit.get_group_rule('id')
      def get_group_rule(id, options = {})
        get("/groups/rules/#{id}", options)
      end

      # List Group Rules
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of Group Rules
      # @see https://developer.okta.com/docs/reference/api/groups/#list-group-rules
      # @example
      #   Oktakit.list_group_rules
      def list_group_rules(options = {})
        get('/groups/rules', options)
      end

      # Update Group Rule
      #
      # @params id [string] Group Rule ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] Updated Group Rule
      # @see https://developer.okta.com/docs/reference/api/groups/#update-group-rule
      # @example
      #   Oktakit.update_group_rule('id')
      def update_group_rule(id, options = {})
        put("/groups/rules/#{id}", options)
      end

      # Remove Group Rule
      #
      # @params id [string] Group ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return  HTTP 202 Accepted
      # @see https://developer.okta.com/docs/reference/api/groups/#delete-a-group-rule
      # @example
      #   Oktakit.remove_group_rule('id')
      def remove_group_rule(id, options = {})
        delete("/groups/rules/#{id}", options)
      end

      # Activate Group Rule
      #
      # @params id [string] Group ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return  HTTP 204 No Content
      # @see https://developer.okta.com/docs/reference/api/groups/#activate-a-group-rule
      # @example
      #   Oktakit.activate_group_rule('id')
      def activate_group_rule(id, options = {})
        post("/groups/rules/#{id}/lifecycle/activate", options)
      end

      # Deactivate Group Rule
      #
      # @params id [string] Group ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return  HTTP 204 No Content
      # @see https://developer.okta.com/docs/reference/api/groups/#deactivate-a-group-rule
      # @example
      #   Oktakit.deactivate_group_rule('id')
      def deactivate_group_rule(id, options = {})
        post("/groups/rules/#{id}/lifecycle/deactivate", options)
      end
    end
  end
end
