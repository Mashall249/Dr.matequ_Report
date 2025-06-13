class CreateAccessLogs < ActiveRecord::Migration[6.1]
  def change
    create_table :access_logs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :material, null: false, foreign_key: true
      t.string :ip_address
      t.string :user_agent
      t.integer :duration

      t.timestamps
    end
  end
end
