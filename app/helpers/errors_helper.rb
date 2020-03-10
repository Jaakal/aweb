module ErrorsHelper
  def login_username(flash)
    unless flash[:notice].nil?
      ' error'
    end
  end

  def login_username_placeholder(flash)
    unless flash[:notice].nil?
      flash[:notice]
    end
  end

  def username(user)
    unless user.errors[:username].nil?
      ' error'
    end
  end
  
  def username_placeholder(user)
    unless user.errors[:username].empty?
      user.errors.messages[:username].first
    end
  end
  
  def full_name(user)
    unless user.errors[:full_name].nil?
      ' error'
    end
  end
  
  def full_name_placeholder(user)
    unless user.errors[:full_name].empty?
      user.errors.messages[:full_name].first
    end
  end
end
