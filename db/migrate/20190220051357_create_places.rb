class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :field_id
      t.string :area
      t.string :area_column
      t.integer :area_row

      t.timestamps
    end
  end
end
