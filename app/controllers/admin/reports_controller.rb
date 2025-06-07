class Admin::ReportsController < ApplicationController

  def index
    @reports = Report.order(created_at: :desc)
    @reports = @reports.where(status: 'unreviewed') if params[:filter] == 'unreviewed'
  end

  def show
    @report = Report.find(params[:id])
  end

  def update
    @report = Report.find(params[:id])
    if @report.update(report_params)
      redirect_to admin_reports_path(@report), notice: "ステータスを更新しました。"
    else
      flash.now[:alert] = "更新に失敗しました。"
      render :show
    end
  end

  private

  def report_params
    params.require(:report).permit(:status)
  end
end
