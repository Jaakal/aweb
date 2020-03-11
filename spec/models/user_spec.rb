require 'rails_helper'

RSpec.describe 'User', type: :model do
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

  let(:user3) do
    User.create(
      username: 'james',
      full_name: 'James Doe'
    )
  end

  it 'gets created with valid params' do
    expect do
      User.create(username: 'jonathan', full_name: 'Jonathan Doe')
    end.to change(User.all, :count).by(1)
  end

  it 'gets not created with blank username' do
    expect do
      User.create(username: '', full_name: 'Jonathan Doe')
    end.to change(User.all, :count).by(0)
  end

  it 'gets not created with too long username' do
    expect do
      User.create(username: 'j' * 21, full_name: 'Jonathan Doe')
    end.to change(User.all, :count).by(0)
  end

  it 'gets not created with blank full name' do
    expect do
      User.create(username: 'jonathan', full_name: '')
    end.to change(User.all, :count).by(0)
  end

  it 'gets not created with too long full name' do
    expect do
      User.create(username: 'jonathan', full_name: 'j' * 51)
    end.to change(User.all, :count).by(0)
  end

  it 'gets not created with already existing username' do
    expect do
      User.create(username: 'john', full_name: 'Jonathan Doe' * 51)
    end.to change(User.all, :count).by(0)
  end

  it 'followees returns user all followees' do
    Following.create(follower_id: user1.id, followed_id: user2.id)
    Following.create(follower_id: user1.id, followed_id: user3.id)
    expect(user1.followees.count).to eq(2)
  end

  it 'followers returns user all followers' do
    Following.create(follower_id: user1.id, followed_id: user2.id)
    Following.create(follower_id: user3.id, followed_id: user2.id)
    expect(user2.followers.count).to eq(2)
  end

  it 'followed_by_someone_you_follow returns correct user' do
    User.current_user = user1
    Following.create(follower_id: user1.id, followed_id: user2.id)
    Following.create(follower_id: user2.id, followed_id: user3.id)
    expect(user3.followed_by_someone_you_follow.first).to eq(user2)
  end

  it 'followed_by_someone_you_dont_follow returns correct user' do
    User.current_user = user1
    Following.create(follower_id: user1.id, followed_id: user2.id)
    Following.create(follower_id: user3.id, followed_id: user2.id)
    expect(user2.followed_by_someone_you_dont_follow.first).to eq(user3)
  end

  it 'followed_by_someone_excluding_you returns correct users' do
    User.current_user = user1
    user4 = User.create(username: 'jill', full_name: 'Jill Doe')
    Following.create(follower_id: user1.id, followed_id: user2.id)
    Following.create(follower_id: user3.id, followed_id: user2.id)
    Following.create(follower_id: user4.id, followed_id: user2.id)
    expect(user1.in?(user2.followed_by_someone_excluding_you)).to be(false)
  end

  it 'all_the_posts_for_timeline returns user all posts' do
    Micropost.create(author_id: user1.id, text: 'This is a first post')
    Micropost.create(author_id: user1.id, text: 'This is a second post')
    expect(user1.all_the_posts_for_timeline.count).to be(2)
  end

  it 'all_the_posts_for_timeline returns user all posts desc order' do
    Micropost.create(author_id: user1.id, text: 'This is a first post')
    post = Micropost.create(author_id: user1.id, text: 'This is a second post')
    expect(user1.all_the_posts_for_timeline.first).to eq(post)
  end
end
