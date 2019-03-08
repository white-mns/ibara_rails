class AddIndexToUploadedCheck < ActiveRecord::Migration[5.2]
  def change
    add_index :uploaded_checks, [:result_no, :generate_no], :unique => false, :name => 'resultno_generateno'
  end
end
