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
        response, http_status = post('/authn', {'username' => username, 'password' => password})

        if 200 == http_status
          if "SUCCESS" == response[:status]
            return true
          elsif "MFA_REQUIRED" == response[:status]
            if (state_token = response[:stateToken]) && (embedded = response[:_embedded])
              if factors = embedded[:factors]
                factors.each do |factor|
                  if "token:software:totp" == factor[:factorType]
                    if links = factor[:_links]
                      if verify = links[:verify]
                        if href = verify[:href]
                          data = {
                            'fid': factor[:id],
                            'stateToken': state_token,
                            'passCode': mfa
                          }

                          response, http_status = post(href.sub(api_endpoint, ''), data)

                          return response, http_status
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
