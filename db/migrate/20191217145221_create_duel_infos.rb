class CreateDuelInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :duel_infos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.integer :left_party_no
      t.integer :right_party_no

      t.timestamps
    end
  end
end
