class AddRequesterENoToMake < ActiveRecord::Migration[5.2]
  def change
    add_column :makes, :requester_e_no, :integer
    add_index :makes,  :requester_e_no
  end
end
