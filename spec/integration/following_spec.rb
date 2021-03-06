require 'rails_helper'

RSpec.feature 'Following', type: :feature do
  include Integration

  before(:each) do
    create_multiple_users
    visit_sign_up_page_and_fill_in_form
    click_button 'Sign up'
    click_link 'Jane Doe'
    find('.follow-user-button').click
  end

  it 'follows user' do
    expect(find('.current-user-count', match: :first)).to have_content(1)
  end

  it 'unfollows user' do
    find('.follow-user-button').click
    expect(find('.current-user-count', match: :first)).to have_content(0)
  end

  it 'link following displays current user followees', js: true do
    click_link 'Profile'
    click_button 'Following'
    expect(find('a[href="/users/jane"]')).to have_content('Jane Doe')
  end

  it 'link followers displays current user followers', js: true do
    log_out
    log_in('jane')
    click_link 'Profile'
    click_button 'Followers'
    expect(all('a[href="/users/john"]').count).to be(2)
  end
end
