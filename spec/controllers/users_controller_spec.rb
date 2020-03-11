require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  include SessionsHelper

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

  describe 'INDEX action' do
    it 'it renders template index if logged in' do
      log_in user1
      get :index
      expect(response).to render_template('users/index')
    end

    it 'it redirects to login path if not logged in' do
      get :index
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'NEW action' do
    it 'it renders template new if not logged in' do
      get :new
      expect(response).to render_template('users/new')
    end

    it 'it redirects to root path if logged in' do
      log_in user1
      get :new
      expect(response).to redirect_to(root_path)
    end
  end

  describe 'CREATE action' do
    it 'it logs newly created user in on valid user data input' do
      post :create, params: { user: { username: 'john', full_name: 'John Doe' } }
      expect(logged_in?).to be(true)
    end

    it 'it redirects to root path newly create user' do
      post :create, params: { user: { username: 'john', full_name: 'John Doe' } }
      expect(response).to redirect_to(root_path)
    end

    it 'it renders template new on invalid user data input' do
      post :create, params: { user: { username: '', full_name: 'John Doe' } }
      expect(response).to render_template('users/new')
    end
  end

  describe 'SEARCH action' do
    it 'it renders partial users/index/who_to_follow' do
      log_in user1
      get :search
      expect(response).to render_template(partial: 'users/index/_who_to_follow')
    end

    it 'redirects to log in page if not logged in' do
      get :search
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'CONNECTION action' do
    it 'it renders template connection on slug following' do
      log_in user1
      get :connection, params: { username: user1.username, slug: 'following' }
      expect(response).to render_template('users/connection')
    end

    it 'it renders template connection on slug followers' do
      log_in user1
      get :connection, params: { username: user1.username, slug: 'followers' }
      expect(response).to render_template('users/connection')
    end

    it 'it redirects to root path if slug is wrong' do
      log_in user1
      get :connection, params: { username: user1.username, slug: 'hack' }
      expect(response).to redirect_to(root_path)
    end

    it 'redirects to log in page if not logged in' do
      get :connection, params: { username: user1.username, slug: 'following' }
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'FOLLOW action' do
    it 'it redirects to followed user path' do
      log_in user1
      get :follow, params: { id: user2.id }
      expect(response).to redirect_to(user_show_path(slug: user2.username))
    end

    it 'redirects to log in page if not logged in' do
      get :follow, params: { id: user2.id }
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'UNFOLLOW action' do
    it 'it redirects to unfollowed user path' do
      log_in user1
      get :follow, params: { id: user2.id }
      get :unfollow, params: { id: user2.id }
      expect(response).to redirect_to(user_show_path(slug: user2.username))
    end

    it 'redirects to log in page if not logged in' do
      get :follow, params: { id: user2.id }
      get :unfollow, params: { id: user2.id }
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'SHOW action' do
    it 'it renders show template' do
      log_in user1
      get :show, params: { slug: user2.username }
      expect(response).to render_template('users/show')
    end

    it 'redirects to log in page if not logged in' do
      get :show, params: { slug: user2.username }
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'USER model methods for what session needs to be availabe' do
    # it 'followed_by_someone_you_follow returns correct user' do
    #   log_in user_1
    #   User.current_user = user_1
    #   Following.create(follower_id: user_1.id, followed_id: user_2.id)
    #   Following.create(follower_id: user_2.id, followed_id: user_3.id)
    #   expect(user_3.followed_by_someone_you_follow.first).to eq(user_2)
    # end

    # it 'followed_by_someone_you_dont_follow returns correct user' do
    #   log_in user_1
    #   User.current_user = user_1
    #   Following.create(follower_id: user_1.id, followed_id: user_2.id)
    #   Following.create(follower_id: user_3.id, followed_id: user_2.id)
    #   expect(user_2.followed_by_someone_you_dont_follow.first).to eq(user_3)
    # end

    # it 'followed_by_someone_excluding_you returns correct users' do
    #   log_in user_1
    #   User.current_user = user_1
    #   user_4 = User.create(username: 'jill', full_name: 'Jill Doe')
    #   Following.create(follower_id: user_1.id, followed_id: user_2.id)
    #   Following.create(follower_id: user_3.id, followed_id: user_2.id)
    #   Following.create(follower_id: user_4.id, followed_id: user_2.id)
    #   expect(user_1.in?(user_2.followed_by_someone_excluding_you)).to be(false)
    # end

    # it 'who_to_follow returns all unfollowed users' do
    #   log_in user_1
    #   user_3
    #   Following.create(follower_id: user_1.id, followed_id: user_2.id)
    #   User.current_user = user_1
    #   expect(user_1.who_to_follow.count).to eq(1)
    # end
  end
end
