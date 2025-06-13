# ログ出力ファイル
set :output, "log/cron.log"

every 1.day, at: '7:00 pm' do
  rake "logs:cleanup"
end