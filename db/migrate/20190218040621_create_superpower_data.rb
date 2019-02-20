class CreateSuperpowerData < ActiveRecord::Migration[5.2]
  def change
    create_table :superpower_data do |t|
      t.integer :superpower_id
      t.string :name
      t.string :text

      t.timestamps
    end
  end
end
