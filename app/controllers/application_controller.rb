require 'twitter'

@@client = Twitter::REST::Client.new do |config|
  config.consumer_key        = 'pfiKi20JE7oyYllDmuYKsTRFM'
  config.consumer_secret     = 'yQRl04QKyte2fIGa37VTLBL9bOSA4NFTFH44apJ6mZ2ql7zUUI'
  config.access_token        = '19039053-2bYQZ9V8gLwRmxXAuerclJraVYRYg0ZQTF1nVDC22'
  config.access_token_secret = 'szyQFDRFBtfgwODX0hXgBjztdk565aoZqBsZJbow7flUv'
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  #before_filter :load_tweets()

  # def self.authorize_access
  #   Twitter::Client.new(:oauth_token => Settings.accounts.twitter.oauth_token,
  #                       :oauth_token_secret => Settings.accounts.twitter.oauth_token_secret,
  #                       :consumer_secret => Settings.accounts.twitter.consumer_secret,
  #                       :consumer_key => Settings.accounts.twitter.consumer_key)
  # end

  def load_tweets(twitter_handle)
    @tweets = @@client.user_timeline(twitter_handle, count="100")#[0..100] # For this demonstration lets keep the tweets limited to the first 5 available.
  end
end
