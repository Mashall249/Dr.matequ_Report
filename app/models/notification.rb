class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notifiable, polymorphic: true

  # 通知先のパスを返す
  def redirect_path
    case notifiable
    when Material
      Rails.application.routes.url_helpers.material_path(notifiable)
    when Comment
      Rails.application.routes.url_helpers.material_path(notifiable.material)
    else
      Rails.application.routes.url_helpers.users_mypage_path
    end
  end
end
