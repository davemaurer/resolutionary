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
end
