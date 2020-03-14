require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  include SessionsHelper

  let(:user1) do
    User.create(
      username: 'john',
      full_name: 'John Doe'
    )
  end

  describe 'Create action' do
    it 'creates a micropost when content valid' do
      log_in user1
      post :create, params: { micropost: { text: 'This is a new post' } }
      expect(@controller.view_assigns['error'].nil?).to be(true)
    end

    it "dosen't create a micropost when content too big" do
      log_in user1
      post :create, params: { micropost: { text: 'p' * 200 } }
      expect(@controller.view_assigns['error'].nil?).to be(false)
    end

    it "dosen't create a micropost when content blank" do
      log_in user1
      post :create, params: { micropost: { text: '' } }
      expect(@controller.view_assigns['error'].nil?).to be(false)
    end
  end

  describe 'user_posts actions' do
    it 'renders posts partial' do
      log_in user1
      get :user_posts, params: { slug: user1.username }
      expect(response).to render_template(partial: 'microposts/_posts')
    end
  end

  describe 'all_posts actions' do
    it 'renders posts partial' do
      log_in user1
      get :all_posts
      expect(response).to render_template(partial: 'microposts/_posts')
    end
  end
end
