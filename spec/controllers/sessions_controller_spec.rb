require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  include SessionsHelper

  let(:user1) do
    User.create(
      username: 'john',
      full_name: 'John Doe'
    )
  end

  describe 'New actions' do
    it 'it redirects to current user INDEX page if logged in' do
      log_in user1
      get :new
      expect(response).to redirect_to(root_path)
    end

    it "it renders template NEW if nobody isn't logged in" do
      get :new
      expect(response).to render_template('sessions/new')
    end
  end

  describe 'Create actions' do
    it 'sets User class variable current_user with valid username' do
      user1
      post :create, params: { session: { username: user1.username } }
      expect(User.current_user).to eq(user1)
    end

    it 'it logs in with valid username' do
      user1
      post :create, params: { session: { username: user1.username } }
      expect(logged_in?).to be(true)
    end

    it 'it redirects to root_path when with valid username' do
      user1
      post :create, params: { session: { username: user1.username } }
      expect(response).to redirect_to(root_path)
    end

    it 'sets flash notice with invalid username' do
      user1
      post :create, params: { session: { username: 'johnny' } }
      expect(flash.notice).to eq('Invalid username')
    end

    it 'renders template NEW with invalid username' do
      user1
      post :create, params: { session: { username: 'johnny' } }
      expect(response).to render_template('sessions/new')
    end
  end

  describe 'Destroy actions' do
    it 'it logs logged in user out' do
      user1
      log_in user1
      post :destroy
      expect(logged_in?).to be(false)
    end

    it 'it redirects to login_path after logging out' do
      user1
      log_in user1
      post :destroy
      expect(response).to redirect_to(login_path)
    end
  end
end
