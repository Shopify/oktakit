module Oktakit
  class Client
    module Groups
      # Add Group
      #
      # @return [Hash<Sawyer::Resource>] The created Group.
      # @see http://developer.okta.com/docs/api/resources/groups.html#add-group
      # @example
      #   Oktakit.add_group
      def add_group(options = {})
        post('/groups', options)
      end

      # Get Group
      #
      # @return [Hash<Sawyer::Resource>] Fetched Group
      # @see http://developer.okta.com/docs/api/resources/groups.html#get-group
      # @example
      #   Oktakit.get_group('id')
      def get_group(id, options = {})
        get("/groups/#{id}", options)
      end

      # List Groups
      #
      # @return [Array<Sawyer::Resource>] Array of Groups
      # @see http://developer.okta.com/docs/api/resources/groups.html#list-groups
      # @example
      #   Oktakit.list_groups
      def list_groups(options = {})
        get('/groups', options)
      end

      # Update Group
      #
      # @return [Hash<Sawyer::Resource>] Updated Group
      # @see http://developer.okta.com/docs/api/resources/groups.html#update-group
      # @example
      #   Oktakit.update_group('id')
      def update_group(id, options = {})
        put("/groups/#{id}", options)
      end

      # Remove Group
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/groups.html#remove-group
      # @example
      #   Oktakit.remove_group('id')
      def remove_group(id, options = {})
        delete("/groups/#{id}", options)
      end

      # List Group Members
      #
      # @return [Array<Sawyer::Resource>] Array of Users
      # @see http://developer.okta.com/docs/api/resources/groups.html#list-group-members
      # @example
      #   Oktakit.list_group_members('id')
      def list_group_members(id, options = {})
        get("/groups/#{id}/users", options)
      end

      # Add User to Group
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/groups.html#add-user-to-group
      # @example
      #   Oktakit.add_user_to_group('group_id', 'user_id')
      def add_user_to_group(group_id, user_id, options = {})
        put("/groups/#{group_id}/users/#{user_id}", options)
      end

      # Remove User from Group
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/groups.html#remove-user-from-group
      # @example
      #   Oktakit.remove_user_from_group('group_id', 'user_id')
      def remove_user_from_group(group_id, user_id, options = {})
        delete("/groups/#{group_id}/users/#{user_id}", options)
      end

      # List Assigned Applications
      #
      # @return [Array<Sawyer::Resource>] Array of Applications
      # @see http://developer.okta.com/docs/api/resources/groups.html#list-assigned-applications
      # @example
      #   Oktakit.list_assigned_applications('id')
      def list_assigned_applications(id, options = {})
        get("/groups/#{id}/apps", options)
      end
    end
  end
end
