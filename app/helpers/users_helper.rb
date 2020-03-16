module UsersHelper
  def headline(user, slug)
    if slug.eql?('following')
      user == current_user ? 'Your followees' : "#{user.full_name} followees"
    elsif slug.eql?('followers')
      user == current_user ? 'Your followers' : "#{user.full_name} followers"
    end
  end

  def user_list(user, slug)
    if slug.eql?('following')
      @user_list = user.followees.includes(:followed_by_someone_you_follow)
    elsif slug.eql?('followers')
      @user_list = user.followers.includes(:followed_by_someone_you_follow)
    end
    @user_list
  end
end
