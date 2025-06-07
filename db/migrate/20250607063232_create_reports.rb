class CreateReports < ActiveRecord::Migration[6.1]
  def change
    create_table :reports do |t|
      t.references :reporatble, polymorphic: true, null: false
      t.references :user, null: false, foreign_key: true
      t.integer :reason, null: false, default: 0
      t.string :status

      t.timestamps
    end
  end
end
