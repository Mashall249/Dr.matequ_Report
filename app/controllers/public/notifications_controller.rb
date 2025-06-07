class Public::NotificationsController < ApplicationController
  before_action :authenticate_user!

  def update
    notification = current_user.notifications.find(params[:id])
    notification.update(read: true)

    # モデルの redirect_path メソッドを使ってリダイレクト
    redirect_to notification.redirect_path
  end
end