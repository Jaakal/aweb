require 'rails_helper'

RSpec.describe MicropostsController, type: :controller do
  include SessionsHelper

  let(:user1) do
    User.create(
      username: 'john',
      full_name: 'John Doe'
    )
  end

  describe 'Create actions' do
    it 'creates a micropost when content valid' do
      log_in user1
      post :create, params: { micropost: { text: 'This is a new post', user_id: user1.id } }
      expect(flash.notice.nil?).to be(true)
    end

    it "dosen't create a micropost when content too big" do
      log_in user1
      post :create, params: { micropost: { text: 'p' * 200, user_id: user1.id } }
      expect(flash.notice.nil?).to be(false)
    end

    it "dosen't create a micropost when content blank" do
      log_in user1
      post :create, params: { micropost: { text: '', user_id: user1.id } }
      expect(flash.notice.nil?).to be(false)
    end
  end

  describe 'Show actions' do
    it 'renders posts partial' do
      log_in user1
      post :create, params: { micropost: { text: 'This is a new post', user_id: user1.id } }
      get :show
      expect(response).to render_template(partial: 'microposts/_posts')
    end
  end
end
