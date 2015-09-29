require 'rails_helper'

RSpec.describe ResolutionsController, type: :controller do
  it 'has a #new' do
    get :new

    expect(response.status).to eq(200)
  end

  it 'creates a resolution' do
    User.create(name: 'David', id: 1, uid: '12345')
    resolution = Resolution.create(title: 'Live Forever',
                                   description: 'So I can see the end of the universe',
                                   user_id: 1)

    expect(resolution.title).to eq('Live Forever')
    expect(resolution.user_id).to eq(1)
  end

  it 'updates a resolution' do
    User.create(name: 'David', id: 1, uid: '12345')
    resolution = Resolution.create(title: 'Live Forever',
                 description: 'So I can see the end of the universe',
                 user_id: 1)

    expect(resolution.title).to eq('Live Forever')
    expect(resolution.user_id).to eq(1)

    resolution.update(title: 'Stay Alive')
    expect(resolution.title).to eq('Stay Alive')
  end

  it 'deletes a resolution' do
    User.create(name: 'David', id: 1, uid: '12345')
    resolution = Resolution.create(title: 'Live Forever',
                                   description: 'So I can see the end of the universe',
                                   user_id: 1)

    expect(Resolution.all.count).to eq(1)

    resolution.destroy

    expect(Resolution.all.count).to eq(0)
  end
end
