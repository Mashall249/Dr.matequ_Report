class Admin::AccessLogsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @logs = AccessLog.includes(:material, :user).order(created_at: :desc).limit(100)
  end
end