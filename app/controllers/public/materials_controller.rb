class Public::MaterialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    @material.user_id = current_user_id
    if @material.save
      redirect_to material_path(@material), notice: "登録に成功しました！"
    else
      @materials = Material.all
      render "index"
    end
  end

  def index
    @materials = Material.all
  end

  def show
    @materials = Material.find(params[:id])
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if @material.update(material_params)
      redirect_to material_path(@material), notice: "更新に成功しました！"
    else
      render "edit"
    end
  end

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to materials_path
  end

  private
   def material_params
    params.require(:material).permit(:name, :body, :url, :is_deleted, :image)
   end

end
