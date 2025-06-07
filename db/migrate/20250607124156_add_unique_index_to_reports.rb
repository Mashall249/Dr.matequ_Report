class AddUniqueIndexToReports < ActiveRecord::Migration[6.1]
  #DB制約で重複防止
  def change
    add_index :reports, [:user_id, :reportable_type, :reportable_id], unique: true, name: "index_reports_on_user_and_reportable"
  end
end
