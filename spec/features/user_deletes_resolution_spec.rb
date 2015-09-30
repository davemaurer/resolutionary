require 'rails_helper'

# feature 'User deletes resolution' do
#   scenario 'successfully', js: true do
#     stub_twitter_timeline
#     user = sign_in_with_twitter
#     user.resolutions.create!(
#       title: 'Get better at testing',
#       description: 'TDD is great!',
#     )
#     resolution_count = Resolution.all.count
#
#     visit dashboard_path
#
#     expect(resolution_count).to eq(1)
#
#     within('.card.a') do
#       click_link('Delete')
#     end
#
#     page.accept_alert 'This will remove your resolution. Are you sure?' do
#       click_button('ok')
#     end
#
#     expect(current_path).to eq(dashboard_path)
#     expect(resolution_count).to eq(0)
#   end
#   DatabaseCleaner.clean!
# end
