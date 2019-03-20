class CreateBattleBuffers < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_buffers do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.integer :act_id
      t.integer :act_sub_id
      t.integer :buffer_type
      t.integer :value

      t.timestamps
    end
  end
end
