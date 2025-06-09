class Admin::MaterialsController < ApplicationController
  before_action :authenticate_admin!

  def index
    #ステータスをタブで切り替えれるようにする定義
    if params[:status].present? && Material.statuses.key?(params[:status])
      @materials = Material.public_send(params[:status]).page(params[:page]).per(10)
    else
      @materials = Material.page(params[:page]).per(10)
    end

    # カウント（全ステータス）
    @status_counts = {
      pending: Material.pending.count,
      approved: Material.approved.count,
      rejected: Material.rejected.count
    }

    respond_to do |format|
      format.html # 通常のブラウザリクエストに対して
      format.js  { render 'admin/materials/index' } # Ajaxリクエスト（jsの混同防止でrender指定)
    end
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

  def destroy
    @material = Material.find(params[:id])
    @material.destroy
    redirect_to admin_materials_path
  end

  private

  def material_params
    params.require(:material).permit(:name, :body, :url, :status, :image, :genre_id)
  end
end
