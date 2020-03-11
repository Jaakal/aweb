module Integration
  def visit_sign_up_page_and_fill_in_form
    visit signup_path
    within('form') do
      fill_in 'Username', with: 'john'
      fill_in 'Full name', with: 'John Doe'
    end
  end

  def sign_up_sign_out
    click_button 'Sign up'
    find('.dropdown-button').click
    click_link 'Log out'
  end

  def log_in(username)
    fill_in 'Username', with: username
    click_button 'Login'
  end

  def log_out
    find('.dropdown-button').click
    click_link 'Log out'
  end

  def create_multiple_users
    visit signup_path
    within('form') do
      fill_in 'Username', with: 'jane'
      fill_in 'Full name', with: 'Jane Doe'
    end
    sign_up_sign_out

    visit signup_path
    within('form') do
      fill_in 'Username', with: 'james'
      fill_in 'Full name', with: 'James Doe'
    end
    sign_up_sign_out
  end
end
