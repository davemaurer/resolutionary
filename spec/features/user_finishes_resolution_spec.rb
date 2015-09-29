require 'rails_helper'

feature 'User finishes resolution' do
  scenario 'successfully' do
    stub_twitter_timeline
    user = sign_in_with_twitter
    user.resolutions.create!(
      title: 'Get better at testing',
      description: 'TDD is great!',
    )

    visit dashboard_path

    expect(page).to have_content('Get better at testing')

    click_on('Mark Complete!')

    expect(page).not_to have_content('Get better at testing')
  end
end
