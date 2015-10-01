require 'rails_helper'

feature 'User goals' do
  scenario 'successfully create' do
    stub_twitter_timeline
    sign_in_with_twitter

    visit dashboard_path

    click_on('Create a Resolution')
    fill_in 'Resolution', with: 'Test my app'
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Create')

    click_on('Add Goal')
    fill_in 'What is the goal you will use to fulfill your resolution', with: 'Test today'
    click_on('Create')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Goal created for Test my app')
  end

  scenario 'unsuccessfully create' do
    stub_twitter_timeline
    sign_in_with_twitter

    visit dashboard_path

    click_on('Create a Resolution')
    fill_in 'Resolution', with: 'Test my app'
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Create')

    click_on('Add Goal')
    fill_in 'What is the goal you will use to fulfill your resolution', with: nil
    click_on('Create')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Please try again')
  end

  scenario 'successfully edit' do
    stub_twitter_timeline
    sign_in_with_twitter

    visit dashboard_path

    click_on('Create a Resolution')
    fill_in 'Resolution', with: 'Test my app'
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Create')

    click_on('Add Goal')
    fill_in 'What is the goal you will use to fulfill your resolution', with: 'Test today'
    click_on('Create')

    click_on('Test my app')
    click_on('Test today')

    fill_in 'What is the goal you will use to fulfill your resolution', with: 'Pushups'
    click_on('Edit')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Goal Updated Successfully')
  end

  scenario 'unsuccessfully edit' do
    stub_twitter_timeline
    sign_in_with_twitter

    visit dashboard_path

    click_on('Create a Resolution')
    fill_in 'Resolution', with: 'Test my app'
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Create')

    click_on('Add Goal')
    fill_in 'What is the goal you will use to fulfill your resolution', with: 'Test today'
    click_on('Create')

    click_on('Test my app')
    click_on('Test today')

    fill_in 'What is the goal you will use to fulfill your resolution', with: nil
    click_on('Edit')

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Please try again')
  end

  scenario 'delete' do
    stub_twitter_timeline
    sign_in_with_twitter

    visit dashboard_path

    click_on('Create a Resolution')
    fill_in 'Resolution', with: 'Test my app'
    fill_in 'Reasons - Why are you doing it?', with: 'To make sure it works properly'
    click_on('Create')

    click_on('Add Goal')
    fill_in 'What is the goal you will use to fulfill your resolution', with: 'Test today'
    click_on('Create')

    click_on('Test my app')

    within('.reveal-modal') do
      click_on('Delete')
    end

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Goal removed')
  end
end
