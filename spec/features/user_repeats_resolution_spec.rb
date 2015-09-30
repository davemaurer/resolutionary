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

    expect(current_path).to eq(user_path(user))

    expect(page).to have_content('Get better at testing')

    click_on('Do this again!')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Get better at testing')
    expect(page).to have_content('Your resolution is now active again')
  end
end
