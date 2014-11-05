# https://github.com/erniebrodeur/pushover
require "net/https"

module Pushover

  class InvalidPushoverToken < StandardError
  end

  class Client
    APP_TOKEN = "a2tEa2k5Pe1KauNoomfbiTsZznb7nB"
    BASE_URL = "https://api.pushover.net/1".freeze
    MESSAGE_ENDPOINT = "#{BASE_URL}/messages.json".freeze
    VALIDATE_ENDPOINT = "#{BASE_URL}/users/validate.json".freeze

    def self.call(*args)
      new(*args).call
    end

    def initialize(user, message, title)
      @user = user
      @message = message
      @title = title
    end

    def call
      url = URI.parse("https://api.pushover.net/1/messages.json")
      req = Net::HTTP::Post.new(url.path)
      req.set_form_data({
        :token => APP_TOKEN,
        :user => user_token,
        :message => @message,
        :title => @title
      })
      res = Net::HTTP.new(url.host, url.port)
      res.use_ssl = true
      res.verify_mode = OpenSSL::SSL::VERIFY_PEER
      response = nil
      res.start {|http| response = http.request(req) }
      return Response.new(JSON.parse(response.body))
    rescue InvalidPushoverToken => e
      puts "Invalid User token"
    end

    private

    def user_token
      raise InvalidPushoverToken if @user.pushover_token.blank?
      @user.pushover_token
    end

  end

  class Response
    attr_accessor :data

    def initialize(data)
      @data = data
    end

    def ok?
      self["status"].to_i == 1
    end

    def inspect
      @data.inspect
    end

    def to_s
      @data.to_s
    end

    def to_h
      @data.dup
    end
  end

end