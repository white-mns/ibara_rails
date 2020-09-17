class AddAssociationNameColumnToNewItem < ActiveRecord::Migration[5.2]
  def change
    add_column :new_items, :association_name, :string
    add_index  :new_items, :association_name
  end
end
