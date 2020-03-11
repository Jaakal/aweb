require 'rails_helper'

RSpec.feature 'User', type: :feature do
  include Integration
  before(:each) { visit_sign_up_page_and_fill_in_form }

  context 'Sign Up' do
    it 'with valid attributes' do
      click_button 'Sign up'
      expect(page).to have_content('John Doe')
    end

    it 'with blank username' do
      fill_in 'Username', with: ''
      click_button 'Sign up'
      expect(find('.username-signup')['placeholder']).to have_content("can't be blank")
    end

    it 'with already taken username' do
      sign_up_sign_out
      visit_sign_up_page_and_fill_in_form
      click_button 'Sign up'
      expect(find('.username-signup')['placeholder']).to have_content('has already been taken')
    end

    it 'with blank full name' do
      fill_in 'Full name', with: ''
      click_button 'Sign up'
      expect(find('.full-name-signup')['placeholder']).to have_content("can't be blank")
    end

    it 'with too long full name' do
      fill_in 'Full name', with: 'a' * 51
      click_button 'Sign up'
      expect(find('.full-name-signup')['placeholder']).to have_content('is too long (maximum is 50 characters)')
    end
  end
end

RSpec.feature 'User', type: :feature do
  include Integration
  before(:each) do
    visit_sign_up_page_and_fill_in_form
  end
  context 'Log in' do
    it 'with valid username' do
      sign_up_sign_out
      visit login_path
      fill_in 'Username', with: 'john'
      click_button 'Login'
      expect(page).to have_content('John Doe')
    end

    it 'with invalid username' do
      sign_up_sign_out
      visit login_path
      fill_in 'Username', with: 'hacker'
      click_button 'Login'
      expect(find('.username-login')['placeholder']).to have_content('Invalid username')
    end
  end
end
