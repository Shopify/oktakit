require 'spec_helper'
require 'byebug'

describe Oktakit do
  it 'should auto paginate' do
    VCR.use_cassette 'pagination', record: :new_episodes do
      users, = client.list_users(paginate: true)
      expect(users.size).to be == 10
    end
  end
end
