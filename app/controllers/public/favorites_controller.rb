class Public::FavoritesController < ApplicationController
  def create
    material = Material.find(params[:material_id])
    favorite = current_user.favorites.new(material_id: material.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
    material = Material.find(params[:material_id])
    favorite = current_user.favorites.find_by(material_id: material.id)
    favorite.destroy
    redirect_to request.referer
  end
end