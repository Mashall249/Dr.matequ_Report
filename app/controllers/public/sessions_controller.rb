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

    #3通りの場合分け（上から存在しない、項目の記載不備、退会済み）
    unless @user
      flash[:alert] = "該当するユーザーが見つかりません"
      return
    end
  
    unless @user.valid_password?(params[:user][:password])
      flash[:alert] = "パスワードが正しくありません"
      return
    end
  
    if @user.is_active == false
      flash[:alert] = "退会済みです。再度ご登録をしてご利用ください"
      redirect_to new_user_registration_path
    end
  end
end
