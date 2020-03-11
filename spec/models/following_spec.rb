require 'rails_helper'

RSpec.describe 'Following', type: :model do
  let(:user1) do
    User.create(
      username: 'john',
      full_name: 'John Doe'
    )
  end

  let(:user2) do
    User.create(
      username: 'jane',
      full_name: 'Jane Doe'
    )
  end

  it 'gets created with valid params' do
    expect do
      Following.create(follower_id: user1.id, followed_id: user2.id)
    end.to change(Following.all, :count).by(1)
  end

  it 'gets not created with invalid follower id' do
    expect do
      Following.create(follower_id: '', followed_id: user2.id)
    end.to change(Following.all, :count).by(0)
  end

  it 'gets not created with invalid followee id' do
    expect do
      Following.create(follower_id: user1.id, followed_id: '')
    end.to change(Following.all, :count).by(0)
  end

  it 'gets not created with invalid follower and followee id' do
    expect do
      Following.create(follower_id: '', followed_id: '')
    end.to change(Following.all, :count).by(0)
  end
end
