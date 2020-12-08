require 'faraday'
require 'oktakit/error'

module Oktakit
  # Faraday response middleware
  module Response
    # This class raises an Oktakit-flavored exception based
    # HTTP status codes returned by the API
    class RaiseError < Faraday::Response::Middleware
      private

      def on_complete(response)
        if (error = Oktakit::Error.from_response(response))
          raise error
        end
      end
    end
  end
end
