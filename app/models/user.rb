class User < ApplicationRecord
  mattr_accessor :who_to_follow_offset, :current_user

  has_many :microposts, foreign_key: :author_id, dependent: :destroy

  has_many :followed, foreign_key: :follower_id, class_name: 'Following', dependent: :destroy
  has_many :followees, through: :followed, source: :followed

  has_many :following, foreign_key: :followed_id, class_name: 'Following', dependent: :destroy
  has_many :followers, through: :following, source: :follower

  has_many :followed_by_someone_you_follow, -> { where(id: current_user.followees).limit(1) },
           through: :following, source: :follower

  has_many :followed_by_someone_you_dont_follow,
           -> { where.not(id: [current_user] + current_user.followees).limit(3) },
           through: :following, source: :follower

  has_many :followed_by_someone_excluding_you, -> { where.not(id: current_user).limit(3) },
           through: :following, source: :follower

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :full_name, presence: true, length: { maximum: 50 }

  def by_someone_you_follow(current_user)
    User.where(id: current_user.followees).where(id: followers).limit(1)
  end

  def who_to_follow
    # puts "++++++++++++++++++++"
    # # Fastest query (4 queries total)
    # puts User.where.not(id: [self.id] + Following.where(follower_id: self.id).pluck(:followed_id)).
    # includes(:followed_by_someone_you_follow).limit(3).offset(self.who_to_follow_offset)
    # puts "...................."
    # # Second fastest query (4 queries total)
    # puts User.where.not(id: [self.id] + self.followeds.ids).includes(:followed_by_someone_you_follow).limit(3).
    # offset(self.who_to_follow_offset)
    # puts "********************"
    # # Slowest query (3 queries total)
    # puts User.where.not(id: User.where(id: self).merge(User.where(id: self.followeds))).
    # includes(:followed_by_someone_you_follow).limit(3).offset(self.who_to_follow_offset)
    # puts "'''''''''''''''''''"

    who_to_follow = User.where.not(id: [id] + Following.where(follower_id: id).pluck(:followed_id))
      .includes(:followed_by_someone_you_follow).order(:created_at)
      .reverse_order.limit(3).offset(who_to_follow_offset)

    if who_to_follow.length < 3
      self.who_to_follow_offset = who_to_follow.empty? ? 0 : 3 - who_to_follow.length
      who_to_follow += User.where.not(id: [id] + Following.where(follower_id: id).pluck(:followed_id))
        .includes(:followed_by_someone_you_follow).order(:created_at)
        .reverse_order.limit(3 - who_to_follow.length).offset(0)
    end

    who_to_follow
  end

  def all_the_posts_for_timeline
    Micropost.where(author_id: [id] + followees.ids).includes(:author).order(:created_at).reverse_order
  end
end
