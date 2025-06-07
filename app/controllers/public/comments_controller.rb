class Public::CommentsController < ApplicationController
  def new
    @material = Material.find(params[:material_id])
    @comment = Comment.new
  end
  
  def create
    @material = Material.find(params[:material_id])
    #　↓@comment = current_user.comment.new(comment_params)と同義(10,11)
    @comment = Comment.new(comment_params)
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
    Comment.find(params[:id]).destroy
    redirect_to material_path(params[:material_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:good_comment, :bad_comment, :star)
  end
end