class CreateBattleInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :battle_infos do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :battle_id
      t.string :battle_page
      t.integer :battle_type

      t.timestamps
    end
  end
end
