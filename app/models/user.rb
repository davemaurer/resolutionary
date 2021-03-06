class User < ActiveRecord::Base
  has_many :resolutions

  def self.from_omniauth(auth_info)
    user = find_or_create_by(uid: auth_info.uid)
    user.update_attributes(name:               auth_info.extra.raw_info.name,
                           profile_image:      auth_info.info.image,
                           oath_token:         auth_info.credentials.token,
                           oauth_token_secret: auth_info.credentials.secret
                           )

    user
  end

  def twitter
    TwitterService.twitter_client(oath_token, oauth_token_secret)
  end

  def inspirational_tweets
    twitter.search("#motivation -rt").first(10)
  end

  def current_resolutions
    resolutions.current.reverse
  end

  def completed_resolutions
    resolutions.completed.reverse
  end

  def forgotten_resolutions
    resolutions.forgotten
  end
end
