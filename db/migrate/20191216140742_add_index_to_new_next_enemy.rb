class AddIndexToNewNextEnemy < ActiveRecord::Migration[5.2]
  def change
    add_index :new_next_enemies, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :new_next_enemies, :enemy_id
  end
end
