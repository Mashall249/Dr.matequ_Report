class Material < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :body, presence: true, length: {minimum: 10}
  validates :url, presence: true

  def get_image(width, height)
    image.variant(resize: "#{width}x#{height}!").processed
  end
end
