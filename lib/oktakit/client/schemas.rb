module Oktakit
  class Client
    module Schemas
      # Get User Schema
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#get-user-schema
      # @example
      #   Oktakit.get_user_schema
      def get_user_schema(options = {})
        get('/meta/schemas/user/default', options)
      end

      # Add Property to User Profile Schema
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#add-property-to-user-profile-schema
      # @example
      #   Oktakit.add_property_to_user_profile_schema
      def add_property_to_user_profile_schema(options = {})
        post('/meta/schemas/user/default', options)
      end

      # Update User Profile Schema Property
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#update-user-profile-schema-property
      # @example
      #   Oktakit.update_user_profile_schema_property
      def update_user_profile_schema_property(options = {})
        post('/meta/schemas/user/default', options)
      end

      # Remove Property from User Profile Schema
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#remove-property-from-user-profile-schema
      # @example
      #   Oktakit.remove_property_from_user_profile_schema
      def remove_property_from_user_profile_schema(options = {})
        post('/meta/schemas/user/default', options)
      end

      # Get App User Schema
      #
      # @params id [string] Application ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see https://developer.okta.com/docs/reference/api/schemas/#get-app-user-schema
      # @example
      #   Oktakit.get_app_user_schema('id')
      def get_app_user_schema(id, options = {})
        get("/meta/schemas/apps/#{id}/default", options)
      end

      # Add Property to App User Profile Schema
      #
      # @params id [string] Application ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see https://developer.okta.com/docs/reference/api/schemas/#add-property-to-app-user-profile-schema
      # @example
      #   Oktakit.add_property_to_app_user_profile_schema('id')
      def add_property_to_app_user_profile_schema(id, options = {})
        post("/meta/schemas/apps/#{id}/default", options)
      end

      # Update App User Profile Schema property
      #
      # @params id [string] Application ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see https://developer.okta.com/docs/reference/api/schemas/#update-app-user-profile-schema-property
      # @example
      #   Oktakit.update_app_user_profile_schema_property('id')
      def update_app_user_profile_schema_property(id, options = {})
        post("/meta/schemas/apps/#{id}/default", options)
      end

      # Remove property from App User Profile Schema
      #
      # @params id [string] Application ID
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see https://developer.okta.com/docs/reference/api/schemas/#remove-property-from-app-user-profile-schema
      # @example
      #   Oktakit.remove_property_from_app_user_profile_schema('id')
      def remove_property_from_app_user_profile_schema(id, options = {})
        post("/meta/schemas/apps/#{id}/default", options)
      end
    end
  end
end
