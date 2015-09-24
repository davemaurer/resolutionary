class User < ActiveRecord::Base
  has_many :resolutions

  def self.from_omniauth(auth_info)
    user = find_or_create_by(uid: auth_info.uid)
    user.update_attributes(name:               auth_info.extra.raw_info.name,
                           profile_image:      auth_info.extra.raw_info.profile_image_url,
                           oath_token:         auth_info.credentials.token,
                           oauth_token_secret: auth_info.credentials.secret
                           )

    user
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = oath_token
      config.access_token_secret = oauth_token_secret
    end
  end

  def twitter_timeline
    twitter_client.home_timeline
  end

  def background_picture
    twitter_client.user.profile_background_image_url_https
  end

  def inspirational_tweets
    twitter_client.search("#motivation -rt").first(10)
  end
end
