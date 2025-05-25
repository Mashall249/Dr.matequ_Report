class Public::UsersController < ApplicationController
  def mypage
    @user = User.find(current_user.id)
    @materials = @user.materials
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to users_mypage_path, notice: "登録情報を更新しました！"
    else
      render :edit
    end
  end

  def withdraw
    @user = User.find(current_user.id)
    @user.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  private

    def user_params
      params.require(:user).permit(:name, :nickname, :email, :clinical_department)
    end

end
