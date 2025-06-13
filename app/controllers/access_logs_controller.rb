class AccessLogsController < ApplicationController
  skip_before_action :verify_authenticity_token

  #記録するための定義（表示とは別）
  def create
    data = JSON.parse(request.body.read)
    ReviewAccessLog.create(
      user: current_user,
      material_id: data["material_id"],
      ip_address: request.remote_ip,
      user_agent: request.user_agent,
      duration: data["duration"].to_i
    )
    head :ok
  end
end
