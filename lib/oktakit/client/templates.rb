module Oktakit
  class Client
    module Templates
      # Add SMS Template
      #
      # @return [Hash<Sawyer::Resource>] The created SMS Template.
      # @see http://developer.okta.com/docs/api/resources/templates.html#add-sms-template
      # @example
      #   Oktakit.add_sms_template
      def add_sms_template(options = {})
        post('/templates/sms', options)
      end

      # Get SMS Template
      #
      # @return [Hash<Sawyer::Resource>] Fetched SMS Template
      # @see http://developer.okta.com/docs/api/resources/templates.html#get-sms-template
      # @example
      #   Oktakit.get_sms_template('id')
      def get_sms_template(id, options = {})
        get("/templates/sms/#{id}", options)
      end

      # List SMS Templates
      #
      # @return [Array<Sawyer::Resource>] Array of SMS Template
      # @see http://developer.okta.com/docs/api/resources/templates.html#list-sms-templates
      # @example
      #   Oktakit.list_sms_templates
      def list_sms_templates(options = {})
        get('/templates/sms', options)
      end

      # Update Sms Template
      #
      # @return [Hash<Sawyer::Resource>] Updated SMS Template
      # @see http://developer.okta.com/docs/api/resources/templates.html#update-sms-template
      # @example
      #   Oktakit.update_sms_template('id')
      def update_sms_template(id, options = {})
        put("/templates/sms/#{id}", options)
      end

      # Partial SMS Template Update
      #
      # @return [Hash<Sawyer::Resource>] Updated Sms Template
      # @see http://developer.okta.com/docs/api/resources/templates.html#partial-sms-template-update
      # @example
      #   Oktakit.partial_sms_template_update('id')
      def partial_sms_template_update(id, options = {})
        post("/templates/sms/#{id}", options)
      end

      # Remove SMS Template
      #
      # @return [Hash<Sawyer::Resource>] There is no content in the response.
      # @see http://developer.okta.com/docs/api/resources/templates.html#remove-sms-template
      # @example
      #   Oktakit.remove_sms_template('id')
      def remove_sms_template(id, options = {})
        delete("/templates/sms/#{id}", options)
      end
    end
  end
end
