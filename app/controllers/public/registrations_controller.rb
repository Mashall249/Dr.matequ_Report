class Public::RegistrationsController < Devise::RegistrationsController
  def after_sign_up_path_for(resource)
    users_mypage_path
  end
end
