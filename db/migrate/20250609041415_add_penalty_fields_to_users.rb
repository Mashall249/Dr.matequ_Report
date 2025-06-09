class AddPenaltyFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :penalty_until, :datetime
    add_column :users, :penalty_count, :integer, default: 0
  end
end
