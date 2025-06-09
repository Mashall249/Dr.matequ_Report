class AddPolymorphicToReports < ActiveRecord::Migration[6.1]
  def change
    add_reference :reports, :reportable, polymorphic: true, null: false
  end
end
