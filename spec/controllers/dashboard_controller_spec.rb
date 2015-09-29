require 'rails_helper'

RSpec.describe DashboardController, type: :controller do
  it 'has a #show' do
    get :show

    expect(response.status).to eq(200)
  end
end
