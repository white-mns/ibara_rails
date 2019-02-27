class RenamePartyColumnToPartyNoParty < ActiveRecord::Migration[5.2]
  def change
      rename_column :parties, :party, :party_no
  end
end
