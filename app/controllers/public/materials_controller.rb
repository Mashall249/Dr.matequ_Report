class Public::MaterialsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit]
  before_action :check_penalty, only: [:new, :edit]

  def new
    @material = Material.new
  end

  def create
    @material = Material.new(material_params)
    @material.user_id = current_user.id
    if @material.save
      User.where.not(id: current_user.id).find_each do |user|
        Notification.create(
          user: user,
          notifiable: @material,
          action: "material_posted",
          read: false
        )
      end
      redirect_to material_path(@material), notice: "登録に成功しました！"
    else
      @materials = Material.approved.page(params[:page]).per(10)
      render :new
    end
  end

  def index
    @materials = Material.approved.page(params[:page]).per(10)
  end

  def show
    @material = Material.find(params[:id])

    #グラフを算出するための定義(ハッシュに変換)
    @star_counts = (1..5).map do |i|
      [i, @material.comments.where(star: i).count]
    end.to_h
    @max_count = @star_counts.values.max
  end

  def edit
    @material = Material.find(params[:id])
  end

  def update
    @material = Material.find(params[:id])
    if @material.update(material_params)
      redirect_to material_path(@material), notice: "更新に成功しました！"
    else
      render :edit
    end
  end

  def destroy
    @material = Material.find(params[:id])
    Notification.where(notifiable: @material).destroy_all
    @material.destroy
    redirect_to materials_path
  end

  def compare
    ids = params[:ids]
    if ids.blank?
      redirect_to materials_path, alert: "比較する投稿を選んでください"
      return
    end

    #最初にまとめて必要な関連情報を取得し、一覧に含まれる投稿だけを取得
    @materials = Material.includes(:genre, :comments).where(id: ids)
  end

  private
   def material_params
    params.require(:material).permit(:name, :body, :url, :status, :image, :genre_id)
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