module Oktakit
  class Client
    module Authentication
      # Authenticate User
      #
      # @param username [String]. Username for authn request
      # @param password [String]. Password for authn request
      # @param mfa [String]. Multi-Factor Token for authn request (only first found "token:software:totp" supported)
      # @example
      #   Oktakit.authn('user', 'pass', 123456)
      def authn(username, password, mfa)
        response, http_status = post('/authn', 'username' => username, 'password' => password)

        factors = []

        if http_status == 200
          if response[:status] == "SUCCESS"
            return response, http_status
          elsif response[:status] == "MFA_REQUIRED"
            if (state_token = response[:stateToken]) && (embedded = response[:_embedded])
              factors = embedded[:factors]
            end
          end
        end

        factors.each do |factor|
          next unless factor[:factorType] == "token:software:totp"

          links = factor[:_links]
          verify = links[:verify]
          href = verify[:href]

          next unless links && verify && href

          data = {
            'fid' => factor[:id],
            'stateToken' => state_token,
            'passCode' => mfa
          }

          response, http_status = post(href.sub(api_endpoint, ''), data)

          return response, http_status
        end
      end
    end
  end
end
