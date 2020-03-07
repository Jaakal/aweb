class Following < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followed, class_name: 'User'

  scope :follower, -> { User.find(:follower_id) }
  scope :followed, -> { User.find(:followed_id) }
end
