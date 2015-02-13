require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = 'pfiKi20JE7oyYllDmuYKsTRFM'
  config.consumer_secret     = 'yQRl04QKyte2fIGa37VTLBL9bOSA4NFTFH44apJ6mZ2ql7zUUI'
  config.access_token        = '19039053-2bYQZ9V8gLwRmxXAuerclJraVYRYg0ZQTF1nVDC22'
  config.access_token_secret = 'szyQFDRFBtfgwODX0hXgBjztdk565aoZqBsZJbow7flUv'
end

p client.user_timeline("djdewitt")