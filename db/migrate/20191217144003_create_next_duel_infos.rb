class CreateNextDuelInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :next_duel_infos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :left_party_no
      t.integer :right_party_no
      t.integer :battle_type

      t.timestamps
    end
  end
end
