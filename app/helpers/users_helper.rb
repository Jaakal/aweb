module UsersHelper
  def headline(slug)
    if slug.eql?('following')
      @headline = 'Your followees'
    elsif slug.eql?('followers')
      @headline = 'Your followers'
    end
    @headline
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
