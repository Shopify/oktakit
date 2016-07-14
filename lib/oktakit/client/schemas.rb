module Oktakit
  class Client
    module Schemas
      # Get User Schema
      #
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#get-user-schema
      # @example
      #   Oktakit.get_user_schema
      def get_user_schema(options = {})
        get('/meta/schemas/user/default', options)
      end

      # Add Property to User Profile Schema
      #
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#add-property-to-user-profile-schema
      # @example
      #   Oktakit.add_property_to_user_profile_schema
      def add_property_to_user_profile_schema(options = {})
        post('/meta/schemas/user/default', options)
      end

      # Update User Profile Schema Property
      #
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#update-user-profile-schema-property
      # @example
      #   Oktakit.update_user_profile_schema_property
      def update_user_profile_schema_property(options = {})
        post('/meta/schemas/user/default', options)
      end

      # Remove Property from User Profile Schema
      #
      # @return [Hash<Sawyer::Resource>] User Schema
      # @see http://developer.okta.com/docs/api/resources/schemas.html#remove-property-from-user-profile-schema
      # @example
      #   Oktakit.remove_property_from_user_profile_schema
      def remove_property_from_user_profile_schema(options = {})
        post('/meta/schemas/user/default', options)
      end
    end
  end
end
