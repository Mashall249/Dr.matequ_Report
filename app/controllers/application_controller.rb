class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :search

  def search
    @q = Material.ransack(params[:q])
    @material = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end

  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :nickname, :email, :clinical_department])
  end
end
