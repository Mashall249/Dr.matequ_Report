class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :material

  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  validates :good_comment, presence: true
  validates :bad_comment, presence: true
end