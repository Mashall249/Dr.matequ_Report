class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :material

  validates :good_comment, presence: true
  validates :bad_comment, presence: true
end
