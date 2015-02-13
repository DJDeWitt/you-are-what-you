require 'net/http'
require 'uri'
require 'Nokogiri'

class User < ActiveRecord::Base

  def self.get_http(url)
    @uri = URI.parse(url)
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @response = @http.request(Net::HTTP::Get.new(@uri.request_uri))
    self.get_html
  end

  def self.get_html # Builds hash of elements from the page HTML via Nokogiri magic
    html_page = Nokogiri::HTML(@response.body)
    elements = {}
    elements[:url] = @uri
    elements[:title] = html_page.at('title').content
    elements[:links] = html_page.search('a')
    elements[:google_results] = html_page.search("cite")
    elements
  end

  def create_client
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'pfiKi20JE7oyYllDmuYKsTRFM'
      config.consumer_secret     = 'yQRl04QKyte2fIGa37VTLBL9bOSA4NFTFH44apJ6mZ2ql7zUUI'
      config.access_token        = '19039053-2bYQZ9V8gLwRmxXAuerclJraVYRYg0ZQTF1nVDC22'
      config.access_token_secret = 'szyQFDRFBtfgwODX0hXgBjztdk565aoZqBsZJbow7flUv'
    end
  end

  def load_tweets(twitter_handle)
    create_client
    @tweets = @client.user_timeline(twitter_handle)[0..2] # For this demonstration lets keep the tweets limited to the first 5 available.
  end

end