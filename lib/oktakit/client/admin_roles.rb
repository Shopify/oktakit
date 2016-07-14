module Oktakit
  class Client
    module AdminRoles
      # List Roles Assigned to User
      #
      # @return [Array<Sawyer::Resource>] Array of Role
      # @see http://developer.okta.com/docs/api/resources/roles.html#list-roles-assigned-to-user
      # @example
      #   Oktakit.list_roles_assigned_to_user('user_id')
      def list_roles_assigned_to_user(user_id, options = {})
        get("/users/#{user_id}/roles", options)
      end

      # Assign Role to User
      #
      # @return [Hash<Sawyer::Resource>] Assigned Role
      # @see http://developer.okta.com/docs/api/resources/roles.html#assign-role-to-user
      # @example
      #   Oktakit.assign_role_to_user('user_id')
      def assign_role_to_user(user_id, options = {})
        post("/users/#{user_id}/roles", options)
      end

      # Unassign Role from User
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/roles.html#unassign-role-from-user
      # @example
      #   Oktakit.unassign_role_from_user('user_id', 'role_id')
      def unassign_role_from_user(user_id, role_id, options = {})
        delete("/users/#{user_id}/roles/#{role_id}", options)
      end

      # List Group Targets for User Admin Role
      #
      # @return [Array<Sawyer::Resource>] Array of Groups
      # @see http://developer.okta.com/docs/api/resources/roles.html#list-group-targets-for-user-admin-role
      # @example
      #   Oktakit.list_group_targets_for_user_admin_role('user_id', 'role_id')
      def list_group_targets_for_user_admin_role(user_id, role_id, options = {})
        get("/users/#{user_id}/roles/#{role_id}/targets/groups", options)
      end

      # Add Group Target to User Admin Role
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/roles.html#add-group-target-to-user-admin-role
      # @example
      #   Oktakit.add_group_target_to_user_admin_role('group_id', 'user_id', 'role_id')
      def add_group_target_to_user_admin_role(group_id, user_id, role_id, options = {})
        put("/users/#{user_id}/roles/#{role_id}/targets/groups/#{group_id}", options)
      end

      # Remove Group Target from User Admin Role
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/roles.html#remove-group-target-from-user-admin-role
      # @example
      #   Oktakit.remove_group_target_from_user_admin_role('group_id', 'user_id', 'role_id')
      def remove_group_target_from_user_admin_role(group_id, user_id, role_id, options = {})
        delete("/users/#{user_id}/roles/#{role_id}/targets/groups/#{group_id}", options)
      end

      # List App Targets for App Admin Role
      #
      # @return [Array<Sawyer::Resource>] Array of Catalog Apps
      # @see http://developer.okta.com/docs/api/resources/roles.html#list-app-targets-for-app-admin-role
      # @example
      #   Oktakit.list_app_targets_for_app_admin_role('user_id', 'role_id')
      def list_app_targets_for_app_admin_role(user_id, role_id, options = {})
        get("/users/#{user_id}/roles/#{role_id}/targets/catalog/apps", options)
      end

      # Add App Target to App Admin Role
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/roles.html#add-app-target-to-app-admin-role
      # @example
      #   Oktakit.add_app_target_to_app_admin_role('user_id', 'role_id')
      def add_app_target_to_app_admin_role(user_id, role_id, app_name, options = {})
        put("/users/#{user_id}/roles/#{role_id}/targets/catalog/apps/#{app_name}", options)
      end

      # Remove App Target from App Admin Role
      #
      # @return  HTTP 204 No Content
      # @see http://developer.okta.com/docs/api/resources/roles.html#remove-app-target-from-app-admin-role
      # @example
      #   Oktakit.remove_app_target_from_app_admin_role('user_id', 'role_id')
      def remove_app_target_from_app_admin_role(user_id, role_id, app_name, options = {})
        delete("/users/#{user_id}/roles/#{role_id}/targets/catalog/apps/#{app_name}", options)
      end
    end
  end
end
