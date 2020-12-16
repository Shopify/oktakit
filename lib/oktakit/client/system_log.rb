module Oktakit
  class Client
    module SystemLog
      # List logs
      #
      # @param options[:query] [Hash] Optional. Query params for request
      # @param options[:headers] [Hash] Optional. Header params for the request.
      # @param options[:accept] [String] Optional. The content type to accept. Default application/json
      # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
      # @param options [Hash] Optional. Body params for request.
      # @return [Array<Sawyer::Resource>] Array of logs
      # @see https://developer.okta.com/docs/reference/api/system-log/#list-events
      # @example
      #   Oktakit.list_logs(paginate: true, query: { since: "2019-06-27T00:00:00Z", until: "2019-06-28T00:00:00Z" })
      def list_logs(options = {})
        get('/logs', options)
      end
    end
  end
end
