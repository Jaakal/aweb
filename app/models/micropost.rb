class Micropost < ApplicationRecord
  belongs_to :author, foreign_key: :author_id, class_name: 'User'

  validates :text, presence: true, length: { maximum: 200 }
end
