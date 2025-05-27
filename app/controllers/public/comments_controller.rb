class Public::CommentsController < ApplicationController
  def new
    material = Material.find(params[:material_id])
    comment = current_user.comment.new(comment_params)
  end
  
  def create
    material = Material.find(params[:material_id])
    comment = current_user.comment.new(comment_params)
    comment.material_id = material.id
    comment.save
    redirect_to material_path(material)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to material_path(params[material_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:good_comment, :bad_comment, :star)
end