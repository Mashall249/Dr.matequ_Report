class Material < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image

  validates :material_name, presence: true
  validates :body, presence: true, length: {minimum: 10}
  validates :url, presence: true

  def get_profile_image
    (profile_image.attached?) ? profile_image : "no_image.jpg"
  end
end
