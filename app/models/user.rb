class User < ApplicationRecord
  has_many :microposts, dependent: :destroy
  has_many :followed, foreign_key: :follower_id, class_name: 'Following'
  has_many :followers, foreign_key: :followed_id, class_name: 'Following'
end
