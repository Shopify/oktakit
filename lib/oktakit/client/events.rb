module Oktakit
  class Client
    module Events
      # List Events
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of Events
      # @see http://developer.okta.com/docs/api/resources/events.html#list-events
      # @example
      #   Oktakit.list_events
      def list_events(options = {})
        get('/events', options)
      end
    end
  end
end
