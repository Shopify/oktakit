require 'spec_helper'

describe Oktakit::Client::Users do
  describe '#users' do
    it 'fetches the API users' do
      VCR.use_cassette 'users', record: :new_episodes do
        users = client.get('/users')
        expect(users).not_to be_nil
      end
    end
  end

  describe '#user' do
    it 'fetches the API user by login' do
      VCR.use_cassette 'user', record: :new_episodes do
        user = client.get('/users?q=julian.nadeau&limit=1').first.to_h
        expect(user).to have_key(:id)
        expect(user).to have_key(:profile)
        %w(firstName lastName login email ssh_public_keys).each do |key|
          expect(user[:profile].to_h).to have_key(key.to_sym)
        end
      end
    end
  end
end
