class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :material

  has_many :notifications, dependent: :destroy

  validates :good_comment, presence: true
  validates :bad_comment, presence: true
end