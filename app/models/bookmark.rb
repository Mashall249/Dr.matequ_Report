class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :material

  validates :user_id, uniqueness: {scope: :material_id}
end
