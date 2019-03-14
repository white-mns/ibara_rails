class CreateNewItemFukas < ActiveRecord::Migration[5.2]
  def change
    create_table :new_item_fukas do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :fuka_id

      t.timestamps
    end
  end
end
