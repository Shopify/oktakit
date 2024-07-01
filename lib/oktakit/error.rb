module Oktakit
  # Custom error class for rescuing from all Okta errors
  class Error < StandardError
    # Returns the appropriate Oktakit::Error subclass based
    # on status and response message
    #
    # @param [Hash] response HTTP response
    # @return [Oktakit::Error]
    def self.from_response(response, status)
      status = status.to_i

      return if response.nil? || status.nil? || status.zero?

      (klass = error(status)) ? klass.new(response, status) : nil
    end

    def self.error(status)
      case status
      when 400      then Oktakit::BadRequest
      when 401      then Oktakit::Unauthorized
      when 403      then Oktakit::Forbidden
      when 404      then Oktakit::NotFound
      when 405      then Oktakit::MethodNotAllowed
      when 406      then Oktakit::NotAcceptable
      when 409      then Oktakit::Conflict
      when 415      then Oktakit::UnsupportedMediaType
      when 422      then Oktakit::UnprocessableEntity
      when 400..499 then Oktakit::ClientError
      when 500      then Oktakit::InternalServerError
      when 501      then Oktakit::NotImplemented
      when 502      then Oktakit::BadGateway
      when 503      then Oktakit::ServiceUnavailable
      when 500..599 then Oktakit::ServerError
      end
    end

    def initialize(response = nil, status = nil)
      @response = response
      @status = status

      super(build_error_message)
    end

    # Array of validation errors
    # @return [Array<Hash>] Error info
    def errors
      if data&.is_a?(Hash)
        data[:errors] || []
      else
        []
      end
    end

    def data
      @data ||= parse_data
    end

    private

    attr_reader :response, :status

    def parse_data
      return '' if response.empty?
      return response unless response.is_a?(String)

      headers = response[:response_headers]
      content_type = headers && headers[:content_type] || ''

      content_type =~ /json/ ? Sawyer::Agent.serializer.decode(body) : body
    end

    def response_message
      case data
      when Hash
        data[:errorSummary]
      when String
        data
      end
    end

    def build_error_message
      message = ''

      message << "#{response[:method].to_s.upcase} " unless response[:method].nil?
      message << "#{redact_url(response[:url].to_s)} : " unless response[:url].nil?
      message << status.to_s
      message << " - #{response_message}" unless response_message.nil? || response_message.empty?

      message
    end

    def redact_url(url_string)
      %w[client_secret access_token].each do |token|
        url_string.gsub!(/#{token}=\S+/, "#{token}=(redacted)") if url_string.include?(token)
      end
      url_string
    end
  end

  # Raised on errors in the 400-499 range
  class ClientError < Error; end

  # Raised when Okta returns a 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when Okta returns a 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when Okta returns a 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when Okta returns a 404 HTTP status code
  class NotFound < ClientError; end

  # Raised when Okta returns a 405 HTTP status code
  class MethodNotAllowed < ClientError; end

  # Raised when Okta returns a 406 HTTP status code
  class NotAcceptable < ClientError; end

  # Raised when Okta returns a 409 HTTP status code
  class Conflict < ClientError; end

  # Raised when Okta returns a 414 HTTP status code
  class UnsupportedMediaType < ClientError; end

  # Raised when Okta returns a 422 HTTP status code
  class UnprocessableEntity < ClientError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when Okta returns a 500 HTTP status code
  class InternalServerError < ServerError; end

  # Raised when Okta returns a 501 HTTP status code
  class NotImplemented < ServerError; end

  # Raised when Okta returns a 502 HTTP status code
  class BadGateway < ServerError; end

  # Raised when Okta returns a 503 HTTP status code
  class ServiceUnavailable < ServerError; end

  # Raised when client fails to provide valid Content-Type
  class MissingContentType < ArgumentError; end
end
