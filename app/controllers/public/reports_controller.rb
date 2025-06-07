class Public::ReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    @reportable = find_reportable
    @report = @reportable.reports.build(report_params)
    @report.user = current_user
    @report.status = 'unreviewed'

    #保存したときに戻る（refererがなければマイページ）挙動
    if @report.save
      redirect_to request.referer || users_mypage_path, notice: "通報ありがとうございました。確認いたします。"
    else
      redirect_to request.referer || users_mypage_path, alert: "通報に失敗しました。"
    end
  end

  private

  #投稿orコメント、どちらの通報なのかを判別して該当レコードを取り出すメソッド
  def find_reportable
    if params[:review_id]
      Review.find(params[:review_id])
    elsif params[:comment_id]
      Comment.find(params[:comment_id])
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def report_params
    params.require(:report).permit(:reason)
  end
end
