class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def mypage
    @user = current_user
    @materials = @user.materials

    if params[:status].present? && Material.statuses.key?(params[:status])
      @materials = @materials.public_send(params[:status])
    end

      @materials = @materials.page(params[:page]).per(10)

    @status_counts = {
      pending: @user.materials.pending.count,
      approved: @user.materials.approved.count,
      rejected: @user.materials.rejected.count
    }

    respond_to do |format|
      format.html
      format.js { render 'mypage' } #Ajaxリクエスト（jsの混同防止でrender指定)
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to users_mypage_path, notice: "登録情報を更新しました！"
    else
      render :edit
    end
  end

  def withdraw
    @user = current_user
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
