require 'rails_helper'

feature 'User tweets resolution' do
  scenario 'successfully' do
    stub_twitter_timeline
    user = sign_in_with_twitter
    user.resolutions.create!(
      title: "Get better at testing",
      description: "TDD is great!",
    )

    visit dashboard_path
    tweet_resolution_name

    expect(page).to have_content("Tweeted successfully!")
    expect_tweet_to_be_posted_to_twitter(
      body: "My new resolution is: Get better at testing!",
    )
  end

  private

  def sign_in_with_twitter
    OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new({
      provider: 'twitter',
      uid: '123545',
      info: {
        image: "http://placehold.it/100x100",
      },
      extra: {
        raw_info: {
          name: "David",
        },
      },
      credentials: {
        token: "token",
        secret: "secret",
      },
    })
    visit root_path
    click_on "sign in with twitter"
    User.find_by_uid('123545')
  end

  def stub_twitter_timeline
    stub_request(:get, "https://api.twitter.com/1.1/search/tweets.json?count=100&q=%23motivation%20-rt")
      .to_return(status: 200, body: "{}", headers: {})
  end

  def tweet_resolution_name
    stub_request(:post, "https://api.twitter.com/1.1/statuses/update.json")
      .to_return(status: 200, body: {id: 1}.to_json, headers: {})
    click_on "Tweet This"
  end

  def expect_tweet_to_be_posted_to_twitter(body:)
    expect(WebMock).to have_requested(:post, "https://api.twitter.com/1.1/statuses/update.json")
      .with(body: { status: body })
  end
end
