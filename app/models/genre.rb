class Genre < ApplicationRecord
  has_many :materials, dependent: :destroy

  validates :genre_name, presence: true
end
