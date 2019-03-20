class AddIndexToBattleBuffer < ActiveRecord::Migration[5.2]
  def change
    add_index :battle_buffers, [:result_no, :battle_id,  :act_id, :act_sub_id, :generate_no], :unique => false, :name => 'resultno_battleid'
    add_index :battle_buffers, [:result_no, :buffer_type, :battle_id,  :act_id, :act_sub_id, :generate_no], :unique => false, :name => 'resultno_buffertype'
    add_index :battle_buffers,  :buffer_type
    add_index :battle_buffers,  :value
  end
end
