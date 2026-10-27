require 'oktakit/version'
require 'oktakit/client'

module Oktakit
  class << self
    def new(**args)
      Client.new(**args)
    end
  end
end
