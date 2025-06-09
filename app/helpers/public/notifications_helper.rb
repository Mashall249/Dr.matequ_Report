module Public::NotificationsHelper
  def notification_message(notification)
    case notification.action
    when "material_posted"
      if notification.notifiable
        "新しく投稿されました。（#{notification.notifiable.name}）"
      else
        "新しく投稿されました。"
      end
    when "comment_posted"
      material_name = notification.notifiable&.material&.name
      if material_name.present?
        "あなたの投稿『#{material_name}』にコメントが付きました"
      else
        "あなたの投稿にコメントが付きました"
      end
    else
      "新しい通知があります"
    end
  end
end