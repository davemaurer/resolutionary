require 'rails_helper'

feature 'User logs in and out with twitter' do
  scenario 'can log in' do
    stub_twitter_timeline
    sign_in_with_twitter
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content("Resolutions")
    expect(page).to have_content("Motivation")
  end

  scenario 'can log out' do
    stub_twitter_timeline
    sign_in_with_twitter
    expect(page).to have_content("Resolutions")
    expect(page).to have_content("Motivation")

    click_on("Logout")
    expect(current_path).to eq(root_path)
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
end
