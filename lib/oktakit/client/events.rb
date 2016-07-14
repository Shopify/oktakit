module Oktakit
  class Client
    module Events
      # List Events
      #
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
