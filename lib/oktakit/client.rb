require "json"
require 'sawyer'
require 'oktakit/response/raise_error'
require 'oktakit/client/admin_roles'
require 'oktakit/client/apps'
require 'oktakit/client/events'
require 'oktakit/client/factors'
require 'oktakit/client/groups'
require 'oktakit/client/group_rules'
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
    include GroupRules
    include IdentityProviders
    include Schemas
    include Templates
    include Users

    # Bytes that path_segment percent-encodes: everything except RFC 3986 unreserved characters.
    PATH_SEGMENT_UNSAFE = /[^A-Za-z0-9\-._~]/n

    # Bytes that request percent-encodes in a full path: everything outside the RFC 2396
    # unreserved and reserved sets, plus any "%" that does not start a valid escape sequence.
    # Existing escapes are preserved so already-encoded segments are not encoded twice.
    REQUEST_PATH_UNSAFE = %r{[^\-_.!~*'()a-zA-Z\d;/?:@&=+$,\[\]%]|%(?![0-9A-Fa-f]{2})}n
    private_constant :PATH_SEGMENT_UNSAFE, :REQUEST_PATH_UNSAFE

    # Default Faraday middleware stack
    MIDDLEWARE = Faraday::RackBuilder.new do |builder|
      builder.use(Oktakit::Response::RaiseError)
      builder.adapter(:net_http)
    end

    def initialize(token: nil, access_token: nil, organization: nil, api_endpoint: nil)
      if organization.nil? && api_endpoint.nil?
        raise ArgumentError, "Please provide either the organization or the api_endpoint argument"
      end

      if (token.nil? && access_token.nil?) || (token && access_token)
        raise ArgumentError, "Please provide either the token or the access_token argument"
      end

      @token = token
      @access_token = access_token
      @organization = organization
      @api_endpoint = api_endpoint
    end

    def api_endpoint
      @api_endpoint || "https://#{@organization.downcase}.okta.com/api/v1"
    end

    # Make a HTTP GET request
    #
    # @param url [String] The path, relative to {#api_endpoint}
    # @param options[:query] [Hash] Optional. Query params for request
    # @param options[:headers] [Hash] Optional. Header params for the request.
    # @param options[:accept] [String] Optional. The content type to accept. Default application/json
    # @param options[:content_type] [String] Optional. The content type for the request. Default application/json
    # @param options[:paginate] [Boolean] Optional. If true, will auto-paginate Okta's API responses.
    # @param options [Hash] Optional. Body params for request.
    # @return [Sawyer::Resource]
    def get(url, options = {})
      should_paginate = options.delete(:paginate)
      request_options = {
        query: options.delete(:query),
        headers: options.delete(:headers),
        accept: options.delete(:accept),
        content_type: options.delete(:content_type),
        paginate: should_paginate,
        data: options,
      }

      resp, status, next_page = request(:get, url, **request_options)

      # If request succeeded and we should paginate, then automatically traverse all next_pages
      if status == 200 && should_paginate
        all_objs = [resp]
        while next_page
          resp, status, next_page = request(:get, next_page, **request_options)
          break unless status == 200 # Return early if page request fails

          all_objs << resp
        end
        resp = all_objs.flatten
      end

      [resp, status]
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
      request(:post, url, query: options.delete(:query), headers: options.delete(:headers),
                          accept: options.delete(:accept), content_type: options.delete(:content_type),
                          data: options)
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
      request(:put, url, query: options.delete(:query), headers: options.delete(:headers),
                         accept: options.delete(:accept), content_type: options.delete(:content_type),
                         data: options)
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
      request(:patch, url, query: options.delete(:query), headers: options.delete(:headers),
                           accept: options.delete(:accept), content_type: options.delete(:content_type),
                           data: options)
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
      request(:delete, url, query: options.delete(:query), headers: options.delete(:headers),
                            accept: options.delete(:accept), content_type: options.delete(:content_type),
                            data: options)
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
      request(:head, url, query: options.delete(:query), headers: options.delete(:headers),
                          accept: options.delete(:accept), content_type: options.delete(:content_type),
                          data: options)
    end

    attr_reader :last_response

    private

    def request(method, path, data:, query:, headers:, accept:, content_type:, paginate: false)
      options = {}
      options[:query] = query || {}
      options[:headers] = headers || {}
      options[:headers][:accept] = accept if accept
      options[:headers][:content_type] = content_type if content_type

      uri = escape_request_path("/api/v1" + path.to_s)
      @last_response = resp = sawyer_agent.call(method, uri, data, options)

      response = [resp.data, resp.status]
      response << absolute_to_relative_url(resp.rels[:next]) if paginate
      response
    end

    # Percent-encode a single value for use as one URL path segment.
    #
    # Everything outside the RFC 3986 unreserved set is percent-encoded, including "?", "#"
    # and "%". Some values cannot be made safe by encoding and are rejected instead:
    #
    # - empty values, "." and "..", which resolve to a different resource;
    # - values containing "/", because Okta decodes "%2F" back into a path separator;
    # - values containing ";", because Okta ignores everything from ";" (or "%3B") onward.
    #
    # Okta only supports fetching logins that contain "/" by user ID.
    #
    # @param value [#to_s] Resource identifier, e.g. an Okta ID or a user login
    # @return [String] The encoded segment
    # @raise [ArgumentError] If the value is empty, ".", "..", or contains "/" or ";"
    def path_segment(value)
      segment = value.to_s
      if segment.empty? || segment == "." || segment == ".." || segment.include?("/") || segment.include?(";")
        raise ArgumentError, "Invalid path segment: #{value.inspect}"
      end

      percent_encode(segment, PATH_SEGMENT_UNSAFE)
    end

    def escape_request_path(path)
      percent_encode(path, REQUEST_PATH_UNSAFE)
    end

    def percent_encode(string, unsafe)
      string.b.gsub(unsafe) { |byte| format("%%%02X", byte.ord) }.force_encoding(Encoding::US_ASCII)
    end

    def sawyer_agent
      @sawyer_agent ||= Sawyer::Agent.new(api_endpoint, sawyer_options) do |http|
        http.headers[:accept] = 'application/json'
        http.headers[:content_type] = 'application/json'
        http.headers[:user_agent] = "Oktakit v#{Oktakit::VERSION}"
        http.headers[:authorization] = "SSWS #{@token}" if @token
        http.headers[:authorization] = "Bearer #{@access_token}" if @access_token
      end
    end

    def sawyer_options
      {
        links_parser: Sawyer::LinkParsers::Simple.new,
        faraday: Faraday.new(builder: MIDDLEWARE),
      }
    end

    def absolute_to_relative_url(next_ref)
      return unless next_ref

      next_ref.href.sub(api_endpoint, '')
    end
  end
end
