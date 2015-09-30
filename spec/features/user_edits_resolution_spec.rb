require 'rails_helper'

feature 'User edits resolution' do
  scenario 'successfully' do
    stub_twitter_timeline
    user = sign_in_with_twitter
    resolution = user.resolutions.create!(
      title: 'Get better at testing',
      description: 'TDD is great!',
    )

    visit dashboard_path

    expect(page).to have_content('Get better at testing')

    click_on('Edit')

    expect(current_path).to eq(edit_resolution_path(resolution.id))

    fill_in 'Resolution', with: 'Test my app'
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Edit')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Test my app')
  end

  scenario 'unsuccessfully' do
    stub_twitter_timeline
    user = sign_in_with_twitter
    resolution = user.resolutions.create!(
      title: 'Get better at testing',
      description: 'TDD is great!',
    )

    visit dashboard_path

    expect(page).to have_content('Get better at testing')

    click_on('Edit')

    expect(current_path).to eq(edit_resolution_path(resolution))

    fill_in 'Resolution', with: nil
    fill_in 'Reasons - Why are you doing it?', with: 'Changing it up'
    click_on('Edit')

    expect(page).to have_content('Please try again')
  end
end
