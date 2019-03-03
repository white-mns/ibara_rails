class CreateMovePartyCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :move_party_counts do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :party_no
      t.integer :landform_id
      t.integer :move_count

      t.timestamps
    end
  end
end
