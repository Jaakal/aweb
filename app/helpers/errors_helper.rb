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

  def post_form(flash)
    @class_name = if flash[:notice].nil?
                    ''
                  else
                    ' error'
                  end
    @class_name
  end

  def post_form_placeholder(flash)
    @placeholder = if flash[:notice].nil?
                     'Compose new post'
                   else
                     'is too long (maximum is 160 characters)'
                   end
    @placeholder
  end
end
