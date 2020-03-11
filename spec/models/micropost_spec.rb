require 'rails_helper'

RSpec.describe 'Micropost', type: :model do
  let(:user1) do
    User.create(
      username: 'john',
      full_name: 'John Doe'
    )
  end

  it 'gets created with valid params' do
    expect do
      Micropost.create(author_id: user1.id, text: 'Testing post')
    end.to change(Micropost.all, :count).by(1)
  end

  it 'gets not created with invalid user id' do
    expect do
      Micropost.create(author_id: '', text: 'Testing post')
    end.to change(Micropost.all, :count).by(0)
  end

  it 'gets not created with empty content' do
    expect do
      Micropost.create(author_id: user1.id, text: '')
    end.to change(Micropost.all, :count).by(0)
  end

  it 'gets not created with too long content' do
    expect do
      Micropost.create(author_id: user1.id, text: 'a' * 161)
    end.to change(Micropost.all, :count).by(0)
  end
end
