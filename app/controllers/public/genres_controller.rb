class Public::GenresController < ApplicationController
  def show
    @genre = Genre.find(params[:id])
    @materials = Material.approved.where(genre_id: @genre.id).page(params[:page]).per(5)
  end
end