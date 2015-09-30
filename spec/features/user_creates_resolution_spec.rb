require 'rails_helper'

feature 'User creates resolution' do
  scenario 'successfully' do
    stub_twitter_timeline
    sign_in_with_twitter

    visit dashboard_path

    click_on('Create a Resolution')

    expect(current_path).to eq(new_resolution_path)

    fill_in 'Resolution', with: 'Test my app'
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Create')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Test my app')
  end

  scenario 'unsuccessfully' do
    stub_twitter_timeline
    sign_in_with_twitter

    visit dashboard_path

    click_on('Create a Resolution')

    expect(current_path).to eq(new_resolution_path)

    fill_in 'Resolution', with: nil
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Create')

    expect(current_path).to eq(resolutions_path)
    expect(page).to have_content('Please try again')
  end
end
