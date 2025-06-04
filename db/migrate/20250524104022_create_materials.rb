class CreateMaterials < ActiveRecord::Migration[6.1]
  def change
    create_table :materials do |t|

      t.integer :user_id, null: false
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.text :body, null: false
      t.string :url, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
