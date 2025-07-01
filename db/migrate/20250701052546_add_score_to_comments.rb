class AddScoreToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :good_score, :decimal, precision: 5, scale: 3
    add_column :comments, :bad_score, :decimal, precision: 5, scale: 3
  end
end
