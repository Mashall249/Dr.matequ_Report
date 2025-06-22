class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search
  before_action :reject_cross_login

  #Ransackを用いた検索機能のための定義
  def search
    @q = Material.approved.ransack(params[:q])
    @material = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :email, :clinical_department])
  end

  private

  #排他ログイン
  def reject_cross_login
    if user_signed_in? && controller_path.start_with?("admin/")
      sign_out(:user)
      redirect_to root_path, alert: "一般ユーザーとしてログイン中のため、管理者ページにはアクセスできません。"
    elsif admin_signed_in? && controller_path.start_with?("public/")
      sign_out(:admin)
      redirect_to root_path, alert: "管理者としてログイン中のため、一般ユーザーのページにはアクセスできません。"
    end
  end
end
