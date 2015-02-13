require 'net/http'
require 'uri'
require 'Nokogiri'



class UsersController < ApplicationController
  #before_action :set_user, only: [:show]
  # before_action :redirect_to_root, unless: :'logged_in?', only: [:new]
  before_filter :create_client

  def index
    create_client
    # # find friends
    # @friend_ids = find_friends(@@client)
    # # find each tweet
    # @tweets = []
    # @friend_ids.each do |friend_id|
    #    @tweets << load_tweets(friend_id)
    #  end
    #return tweets of all friends
    #@tweets = load_tweets("djdewitt")

    #@more_tweets = load_tweets("theandrewbriggs")
    #@tweets = @@client.followers("djdewitt")[0..2]

    temp_usernames =
    %w(
    ProLinkGLOBAL
    NIJC
    TeaPartyOrg
    MigrantVoiceUK
    politico
    nytimesworld
    EconBizFin
    ImmPolicyCenter
    FAIRImmigration
    )

  p ""
  p ""
  p ""

  temp_usernames.each do |temp_username|
   twitter_object = @@client.user(temp_username)
    @user_create_string = "User.create({provider: 'twitter', uid: '" + twitter_object.id.to_s + "', username: '" + temp_username + "', twitter: 'https://twitter.com/" + temp_username + "', avatar: '" + twitter_object.profile_image_url + "', name: '" + twitter_object.name + "', bio: '" + twitter_object.description + "'})"
    p ""
    p @user_create_string
    p ""
  end

  p ""
  p ""
  p ""

    # Testing out Twitter Data Flow
    # issue_user_names = ["2787048600","19039053","45248228","145541195","2400631"]

    # @issue_ids = ["2787048600","19039053","45248228","145541195","2400631"]

    # # issue_user_names.each do |id|
    # #   @issue_ids << @@client.user(id).id
    # # end

    # test_user_name = "happygeometry"

    #@@client.follow('ggreenwald')

    # @g_id = @@client.user("neiltyson").id
    # @g_screen = @@client.user("ggreenwald").screen_name
    # @g_name = @@client.user("ggreenwald").name
    # @g_profile_image = @@client.user("ggreenwald").profile_image_url


    # Getting Array of Follower IDs
    # @followers = @@client.follower_ids(test_user_name)

    # puts @followers

    # @follower_ids = []

    # Using IDs to get array of screen_name strings
    # @followers.each do |follower_id|
    #   @follower_ids << @@client.user(follower_id)
    # end

    # Creating a new array that provides the intersection of issue experts
    # @intersection = @followers & @issue_ids

    # Finding Experts that your Expert Friends follow
     # @expert_friends_two = []

    # @intersection.each do |inter|

    #     # Getting Array of Follower IDs
    #     @followers = @@client.follower_ids(inter)
    #     @follower_names = []
    #     # Using IDs to get array of screen_name strings
    #     @followers.each do |follower_id|
    #       @follower_names << @@client.user(follower_id).screen_name
    #     end

    #     # Creating a new array that provides the intersection of issue experts
    #     @common = @follower_names & issue_user_names

    #     @expert_friends_two += @common

    # end




  end

  def show
    @user = params[:id]

    @uri = URI.parse('http://wefollow.com/interest/feminism')
    @http = Net::HTTP.new(@uri.host, @uri.port)
    @response = @http.request(Net::HTTP::Get.new(@uri.request_uri))
    @html_page = Nokogiri::HTML(@response.body)
    elements = {}
    elements[:url] = @uri
    elements[:title] = @html_page.at('title').content
    elements[:links] = @html_page.search('a')
    elements[:google_results] = @html_page.search("cite")
    elements[:user_name] = @html_page.search('.user-name')
    elements[:user_username] = @html_page.search('.user-username')
    elements[:user_bio] = @html_page.search('.user-bio')
    elements

    @user = elements
  end

  def load_tweets(twitter_handle)
    tweets = @@client.user_timeline(twitter_handle, count: 100 ) # For this demonstration lets keep the tweets limited to the first 5 available.
  end

  def create_client
    @@client = Twitter::REST::Client.new do |config|
      config.consumer_key        = 'pfiKi20JE7oyYllDmuYKsTRFM'
      config.consumer_secret     = 'yQRl04QKyte2fIGa37VTLBL9bOSA4NFTFH44apJ6mZ2ql7zUUI'
      config.access_token        = '19039053-2bYQZ9V8gLwRmxXAuerclJraVYRYg0ZQTF1nVDC22'
      config.access_token_secret = 'szyQFDRFBtfgwODX0hXgBjztdk565aoZqBsZJbow7flUv'
    end
  end

  def find_friends(client)
    cursor = "-1"
    followerIds = []
      while cursor != 0 do
       followers = Twitter.follower_ids("IDTOLOOKUP",{:cursor=>cursor})

       cursor = followers.next_cursor
       followerIds+= followers.ids
       sleep(2)
      end
    followerIds
  end

  # def self.get_http(url)
  #   @uri = URI.parse(url)
  #   @http = Net::HTTP.new(@uri.host, @uri.port)
  #   @response = @http.request(Net::HTTP::Get.new(@uri.request_uri))
  #   self.get_html
  # end

  # def self.get_html # Builds hash of elements from the page HTML via Nokogiri magic
  #   html_page = Nokogiri::HTML(@response.body)
  #   elements = {}
  #   elements[:url] = @uri
  #   elements[:title] = html_page.at('title').content
  #   elements[:links] = html_page.search('a')
  #   elements[:google_results] = html_page.search("cite")
  #   elements
  # end


  # private

  # def question_params
  #     params.require(:question).permit(:title, :content, :tag_names)
  # end

end