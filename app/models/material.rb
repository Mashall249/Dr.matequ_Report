class Material < ApplicationRecord
  belongs_to :user
  belongs_to :genre
  
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy
  has_many :reports, as: :reportable, dependent: :destroy

  has_one_attached :image

  validates :name, presence: true
  validates :body, presence: true, length: { minimum: 10 }
  validates :url, presence: true

  #承認ステータスの定義
  enum status: { pending: 0, approved: 1, rejected: 2 }

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
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def get_image(width, height)
    image.variant(resize: "#{width}x#{height}!").processed
  end

  #Ransack用のモデルコード
  def self.ransackable_attributes(auth_object = nil)
    %w[name body created_at genre_id id is_deleted updated_at url user_id]
  end
end
