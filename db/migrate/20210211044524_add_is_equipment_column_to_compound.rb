class AddIsEquipmentColumnToCompound < ActiveRecord::Migration[6.0]
  def change
    add_column :compounds, :is_equipment, :integer
    add_index  :compounds, :is_equipment
  end
end
