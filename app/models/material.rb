class Material < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :body, presence: true, length: {minimum: 10}
  validates :url, presence: true

  #機器検索のための定義
  def self.search_for(content, method)
    if method == 'perfect'
      Material.where(name: content)
    elsif method == 'forward'
      Material.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Material.where('name LIKE ?', '%' + content)
    else
      Material.where('name LIKE ?', '%' + content + '%')
    end

  def get_image(width, height)
    image.variant(resize: "#{width}x#{height}!").processed
  end
end
