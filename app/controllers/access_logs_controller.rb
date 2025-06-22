class AccessLogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  #記録するための定義（表示とは別）
  def create
    data = JSON.parse(request.body.read)
    AccessLog.create(
      user: current_user,
      material_id: data["material_id"],
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      duration: data["duration"].to_i
    )
    
    if access_log.save
      head :ok
    else
      Rails.logger.error "アクセスログ保存失敗: #{access_log.errors.full_messages}"
      render json: { error: "ログ保存失敗", details: access_log.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
