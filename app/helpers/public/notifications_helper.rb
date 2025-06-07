module Public::NotificationsHelper
  def notification_message(notification)
    case notification.action
    when "material_posted"
      "新しく投稿されました。（#{notification.notifiable.name}）"
    when "comment_posted"
      "あなたの投稿『#{notification.notifiable.material.name}』にコメントが付きました"
    else
      "新しい通知があります"
    end
  end
end