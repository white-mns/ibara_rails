class AddSourceNameColumnToMake < ActiveRecord::Migration[5.2]
  def change
    add_column :makes, :source_name, :string
    add_index  :makes, :source_name
  end
end
