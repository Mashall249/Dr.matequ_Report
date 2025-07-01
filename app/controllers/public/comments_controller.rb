class Public::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_penalty, only: [:new, :edit]
  
  def new
    @material = Material.find(params[:material_id])
    @comment = Comment.new
  end
  
  def create
    @material = Material.find(params[:material_id])
    #　↓@comment = current_user.comment.new(comment_params)と同義(下2行)
    @comment = Comment.new(comment_params)
    @comment.good_score = Language.get_data(comment_params[:good_comment])
    @comment.bad_score = Language.get_data(comment_params[:bad_comment])
    @comment.user_id = current_user.id
    @comment.material_id = @material.id
    if @comment.save
      # 投稿者に通知（ただし自分のには通知しない）
      if @material.user != current_user
        Notification.create(
          user: @material.user,
          notifiable: @comment,
          action: "comment_posted",
          read: false
        )
      end
      redirect_to @material, notice: "コメントしました。"
    else
      render :new
    end
  end

  def destroy
    comment = Comment.find(params[:id])
  
    # 通知も削除（ポリモーフィックで）
    Notification.where(notifiable: comment).destroy_all

    comment.destroy
    redirect_to material_path(params[:material_id]), notice: "コメントを削除しました。"
  end

  private

  def comment_params
    params.require(:comment).permit(:good_comment, :bad_comment, :star)
  end

  #ペナルティ処理
  def check_penalty
    #期間制限
    if current_user.penalty_until.present? && current_user.penalty_until > Time.current
      redirect_to users_mypage_path, alert: "現在、#{current_user.penalty_until.strftime('%Y-%m-%d %H:%M')}まで投稿が制限されています。"
    #回数制限(上限を超えると退会処理)
    elsif current_user.penalty_count >= 3
      current_user.update!(is_active: false)
      reset_session
      redirect_to root_path, alert: "ペナルティ累積によりアカウントが停止されました。"
    end
  end
end