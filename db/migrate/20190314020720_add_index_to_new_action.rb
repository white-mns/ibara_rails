class AddIndexToNewAction < ActiveRecord::Migration[5.2]
  def change
    add_index :new_actions, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
    add_index :new_actions, :skill_id
    add_index :new_actions, :fuka_id
  end
end
