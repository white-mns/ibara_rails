class CreateNewNextEnemies < ActiveRecord::Migration[5.2]
  def change
    create_table :new_next_enemies do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :enemy_id

      t.timestamps
    end
  end
end
