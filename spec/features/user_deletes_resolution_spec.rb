require 'rails_helper'

feature 'User deletes resolution' do
  scenario 'successfully' do
    stub_twitter_timeline
    user = sign_in_with_twitter
    user.resolutions.create!(
      title: 'Get better at testing',
      description: 'TDD is great!',
    )
    resolution_count = Resolution.all.count

    visit dashboard_path

    expect(resolution_count).to eq(1)

    click_link('Delete')

    expect(current_path).to eq(dashboard_path)
  end
end
