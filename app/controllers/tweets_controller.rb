class TweetsController < ApplicationController
  def create
    tweet_body = "My new resolution is: #{resolution.title}!"
    send_tweet(tweet_body)
    redirect_to dashboard_path, flash: { notice: "Tweeted successfully!" }
  end

  private

  def resolution
    @resolution ||= Resolution.find(params[:resolution_id])
  end

  def send_tweet(tweet_body)
    current_user.twitter.update(tweet_body)
  end
end
