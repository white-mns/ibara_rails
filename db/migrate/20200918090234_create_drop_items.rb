class CreateDropItems < ActiveRecord::Migration[5.2]
  def change
    create_table :drop_items do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.string :name
      t.integer :plus

      t.timestamps
    end
  end
end
