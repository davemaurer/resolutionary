require 'rails_helper'

feature 'User tweets resolution' do
  scenario 'successfully' do
    stub_twitter_timeline
    user = sign_in_with_twitter
    user.resolutions.create!(
      title: 'Get better at testing',
      description: 'TDD is great!',
    )

    visit dashboard_path
    tweet_resolution_name

    expect(page).to have_content('Tweeted successfully!')
    expect_tweet_to_be_posted_to_twitter(
      body: 'My new resolution is: Get better at testing!',
    )
  end
end
