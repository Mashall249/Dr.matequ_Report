#手動で記録を削除するためのコード
namespace :logs do
  desc "2週間より古いアクセスログを削除する"
  task cleanup: :environment do
    deleted = AccessLog.where("created_at < ?", 2.weeks.ago).delete_all
    puts "#{deleted} 件の古いアクセスログを削除しました"
  end
end