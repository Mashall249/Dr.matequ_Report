class Public::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]

  def after_sign_in_path_for(resource)
    users_mypage_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def reject_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_active == false)
        flash[:alert] = "退会済みです。再度ご登録をしてご利用ください"
        redirect_to new_user_registration_path
      else
        flash[:alert] = "項目を入力してください"
      end
    else
      flash[:alert] = "該当するユーザーが見つかりません"
    end
  end
end
