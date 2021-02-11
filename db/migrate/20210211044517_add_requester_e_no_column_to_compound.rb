class AddRequesterENoColumnToCompound < ActiveRecord::Migration[6.0]
  def change
    add_column :compounds, :requester_e_no, :integer
    add_index  :compounds, :requester_e_no
  end
end
