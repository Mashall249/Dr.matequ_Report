class Public::BookmarksController < ApplicationController
  def create
    @material = Material.find(params[:material_id])
    bookmark = current_user.bookmarks.new(material_id: @material.id)
    bookmark.save
  end

  def destroy
    @material = Material.find(params[:material_id])
    bookmark = current_user.bookmarks.find_by(material_id: @material.id)
    bookmark.destroy
  end
end
