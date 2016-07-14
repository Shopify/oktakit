require 'sawyer'
require 'oktakit/response/raise_error'
require 'oktakit/client/admin_roles'
require 'oktakit/client/apps'
require 'oktakit/client/events'
require 'oktakit/client/factors'
require 'oktakit/client/groups'
require 'oktakit/client/identity_providers'
require 'oktakit/client/schemas'
require 'oktakit/client/templates'
require 'oktakit/client/users'

module Oktakit
  class Client
    include AdminRoles
    include Apps
    include Events
    include Factors
    include Groups
    include IdentityProviders
    include Schemas
    include Templates
    include Users

    # In Faraday 0.9, Faraday::Builder was renamed to Faraday::RackBuilder
    RACK_BUILDER_CLASS = defined?(Faraday::RackBuilder) ? Faraday::RackBuilder : Faraday::Builder

    # Default Faraday middleware stack
    MIDDLEWARE = RACK_BUILDER_CLASS.new do |builder|
      builder.use Oktakit::Response::RaiseError
      builder.adapter Faraday.default_adapter
    end

    def initialize(token:, organization:)
      @token = token
      @organization = organization
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options[:query] [Hash] Optional. Query params for request
    # @param options[:headers] [Hash] Optional. Header params for the request.
    # @param options[:accept] [String] Optional. The content type to accept. Default application/json
    # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
    # @param options [Hash] Optional. Body params for request.
    # @return [Sawyer::Resource]
    def get(url, options = {})
      request :get, url, query: options.delete(:query), headers: options.delete(:headers),
                         accept: options.delete(:accept), content_type: options.delete(:content_type),
                         data: options
    end

    # Make a HTTP POST request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options[:query] [Hash] Optional. Query params for request
    # @param options[:headers] [Hash] Optional. Header params for the request.
    # @param options[:accept] [String] Optional. The content type to accept. Default application/json
    # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
    # @param options [Hash] Optional. Body params for request.
    # @return [Sawyer::Resource]
    def post(url, options = {})
      request :post, url, query: options.delete(:query), headers: options.delete(:headers),
                          accept: options.delete(:accept), content_type: options.delete(:content_type),
                          data: options
    end

    # Make a HTTP PUT request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options[:query] [Hash] Optional. Query params for request
    # @param options[:headers] [Hash] Optional. Header params for the request.
    # @param options[:accept] [String] Optional. The content type to accept. Default application/json
    # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
    # @param options [Hash] Optional. Body params for request.
    # @return [Sawyer::Resource]
    def put(url, options = {})
      request :put, url, query: options.delete(:query), headers: options.delete(:headers),
                         accept: options.delete(:accept), content_type: options.delete(:content_type),
                         data: options
    end

    # Make a HTTP PATCH request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options[:query] [Hash] Optional. Query params for request
    # @param options[:headers] [Hash] Optional. Header params for the request.
    # @param options[:accept] [String] Optional. The content type to accept. Default application/json
    # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
    # @param options [Hash] Optional. Body params for request.
    # @return [Sawyer::Resource]
    def patch(url, options = {})
      request :patch, url, query: options.delete(:query), headers: options.delete(:headers),
                           accept: options.delete(:accept), content_type: options.delete(:content_type),
                           data: options
    end

    # Make a HTTP DELETE request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options[:query] [Hash] Optional. Query params for request
    # @param options[:headers] [Hash] Optional. Header params for the request.
    # @param options[:accept] [String] Optional. The content type to accept. Default application/json
    # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
    # @param options [Hash] Optional. Body params for request.
    # @return [Sawyer::Resource]
    def delete(url, options = {})
      request :delete, url, query: options.delete(:query), headers: options.delete(:headers),
                            accept: options.delete(:accept), content_type: options.delete(:content_type),
                            data: options
    end

    # Make a HTTP HEAD request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options[:query] [Hash] Optional. Query params for request
    # @param options[:headers] [Hash] Optional. Header params for the request.
    # @param options[:accept] [String] Optional. The content type to accept. Default application/json
    # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
    # @param options [Hash] Optional. Body params for request.
    # @return [Sawyer::Resource]
    def head(url, options = {})
      request :head, url, query: options.delete(:query), headers: options.delete(:headers),
                          accept: options.delete(:accept), content_type: options.delete(:content_type),
                          data: options
    end

    attr_reader :last_response

    private

    def request(method, path, data:, query:, headers:, accept:, content_type:)
      options = {}
      options[:query] = query || {}
      options[:headers] = headers || {}
      options[:headers][:accept] = accept if accept
      options[:headers][:content_type] = content_type if content_type

      uri = URI::Parser.new.escape("/api/v1/" + path.to_s)
      @last_response = response = sawyer_agent.call(method, uri, data, options)
      [response.data, response.status]
    end

    def sawyer_agent
      @agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
        http.headers[:accept] = 'application/json'
        http.headers[:content_type] = 'application/json'
        http.headers[:user_agent] = "Oktakit v#{Oktakit::VERSION}"
        http.authorization 'SSWS ', @token
      end
    end

    def sawyer_options
      {
        links_parser: Sawyer::LinkParsers::Simple.new,
        faraday: Faraday.new(builder: MIDDLEWARE),
      }
    end

    def api_endpoint
      "https://#{@organization}.okta.com/api/v1/"
    end
  end
end
