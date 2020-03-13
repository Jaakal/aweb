require 'rails_helper'

RSpec.feature 'Micropost', type: :feature do
  include Integration

  before(:each) do
    visit_sign_up_page_and_fill_in_form
    click_button 'Sign up'
  end

  context 'Create micropost' do
    it 'with valid content', js: true do
      fill_in 'Post something', with: 'New post!'
      find('.post-submit-button').click
      expect(page).to have_content('New post!')
    end

    it 'with too long content', js: true do
      fill_in 'Post something', with: 'a' * 161
      find('.post-submit-button').click
      expect(find('input.text-field')['placeholder']).to have_content('is too long (maximum is 160 characters)')
    end
  end
end
