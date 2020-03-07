class User < ApplicationRecord
  mattr_accessor :who_to_follow_offset

  has_many :microposts, foreign_key: :author_id, dependent: :destroy
  has_many :followed, foreign_key: :follower_id, class_name: 'Following', dependent: :destroy
  # has_many :followers, foreign_key: :followed_id, class_name: 'Following', dependent: :destroy
  has_many :followers, foreign_key: :followed_id, class_name: 'Following', dependent: :destroy

  # has_many :followings
  # has_many :friends, :through => :followings, :source => 'followed'

  # has_many :followeds, :class_name => 'Following', :foreign_key => 'followed_id'
  has_many :followings, foreign_key: :follower_id, class_name: 'Following', dependent: :destroy
  has_many :followeds, through: :followings, source: :followed
  
  has_many :stalkings, foreign_key: :followed_id, class_name: 'Following', dependent: :destroy
  has_many :stalkers, through: :stalkings, source: :follower
  
  has_many :followed_by_someone_you_follow, -> { limit(1) }, through: :stalkings, source: :follower

  # scope :with_long_title, -> { where("LENGTH(title) > 20") }

  validates :username, presence: true, length: { maximum: 20 }, uniqueness: true
  validates :full_name, presence: true, length: { maximum: 50 }

  self.who_to_follow_offset = 0

  def who_to_follow
    who_to_follow = User.where.not(id: [self.id] + Following.where(follower_id: self.id).pluck(:followed_id)).includes(:followed_by_someone_you_follow).limit(3).offset(self.who_to_follow_offset)

    if who_to_follow.length < 3
      self.who_to_follow_offset = 3 - who_to_follow.length
      who_to_follow += User.where.not(id: [self.id] + Following.where(follower_id: self.id).pluck(:followed_id)).includes(:followers).limit(3 - who_to_follow.length).offset(0)
    end
    
    puts "++++++++++++++++++++"
    puts self.followed.pluck(:followed_id).inspect
    
    who_to_follow.each do |user|
      puts "#{user.full_name} --------------------"
      # puts user.followers.pluck(:follower_id)
      puts "======================="
      puts  user.followed_by_someone_you_follow.first.full_name unless user.followed_by_someone_you_follow.empty?
      # puts  user.followed_by_someone_you_follow.empty?
      # puts user.followed_by_someone_you_follow..length unless user.followed_by_someone_you_follow.empty?
      # puts user.followed_by_someone_you_follow.full_name unless user.followed_by_someone_you_follow.empty?
      puts "======================="
      # puts user.followers.first.follower.full_name unless user.followers.first.nil?
    end

    puts "++++++++++++++++++++"


    who_to_follow
  end
end
