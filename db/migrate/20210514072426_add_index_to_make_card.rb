class AddIndexToMakeCard < ActiveRecord::Migration[6.0]
  def change
    add_index :make_cards, [:result_no, :e_no, :generate_no], :unique => false, :name => 'resultno_eno'
    add_index :make_cards, :receiver_e_no
    add_index :make_cards, :name
    add_index :make_cards, :skill_id
    add_index :make_cards, :card_no
  end
end
