class CreateMakeCards < ActiveRecord::Migration[6.0]
  def change
    create_table :make_cards do |t|
      t.integer :result_no
      t.integer :generate_no
      t.integer :e_no
      t.integer :receiver_e_no
      t.string :name
      t.integer :skill_id
      t.integer :card_no

      t.timestamps
    end
  end
end
