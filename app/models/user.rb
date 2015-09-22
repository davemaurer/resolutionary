class User < ActiveRecord::Base

  def self.from_omniauth(auth_info)
    user = find_or_create_by(uid: auth_info.uid)
    user.update_attributes(
      name:               auth_info.extra.raw_info.name,
      profile_image:      auth_info.extra.raw_info.profile_image_url,
      oauth_token:        auth_info.credentials.token,
      oauth_token_secret: auth_info.credentials.secret
    )
    user
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_KEY']
      config.consumer_secret = ENV['TWITTER_SECRET']
      config.access_token = oauth_token
      config.access_token_secret = oauth_token_secret
    end
  end
end
