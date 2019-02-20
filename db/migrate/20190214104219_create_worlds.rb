class CreateWorlds < ActiveRecord::Migration[5.2]
  def change
    create_table :worlds do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :world

      t.timestamps
    end
  end
end
