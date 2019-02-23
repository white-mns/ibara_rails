class CreateCards < ActiveRecord::Migration[5.2]
  def change
    create_table :cards do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.string :name
      t.integer :skill_id
      t.integer :made_e_no

      t.timestamps
    end
  end
end
