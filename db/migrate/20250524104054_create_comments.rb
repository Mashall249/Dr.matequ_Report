class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.integer :user_id, null: false
      t.integer :material_id, null: false
      t.text :good_comment, null: false
      t.text :bad_comment, null: false
      t.float :star, null: false
      t.timestamps
    end
  end
end
