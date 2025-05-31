class Admin::MaterialsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @materials = Material.page(params[:page]).per(10)
  end

  def show
    @material = Material.find(params[:id])
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if @material.update(material_params)
      redirect_to admin_material_path(@material), notice: "更新に成功しました"
    else
      flash.now[:alert] = "エラーが発生しました"
      render :edit
    end
  end

  private

  def material_params
    params.require(:material).permit(:name, :body, :url, :is_deleted, :image, :genre_id)
  end
end
