module ErrorsHelper
  def login_username(flash)
    ' error' unless flash[:notice].nil?
  end

  def login_username_placeholder(flash)
    flash[:notice] unless flash[:notice].nil?
  end

  def username(user)
    ' error' unless user.errors[:username].nil?
  end

  def username_placeholder(user)
    user.errors.messages[:username].first unless user.errors[:username].empty?
  end

  def full_name(user)
    ' error' unless user.errors[:full_name].nil?
  end

  def full_name_placeholder(user)
    user.errors.messages[:full_name].first unless user.errors[:full_name].empty?
  end
end
