require 'spec_helper'

describe Oktakit do
  it 'has a version number' do
    expect(Oktakit::VERSION).not_to be nil
  end

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

  describe 'errors' do
    it 'raises a Oktakit::NotFound on 404 responses' do
      VCR.use_cassette '404' do
        expect { client.get('/users/-1') }.to raise_error(Oktakit::NotFound)
      end
    end
  end
end
