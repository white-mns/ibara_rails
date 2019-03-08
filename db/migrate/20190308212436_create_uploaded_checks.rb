class CreateUploadedChecks < ActiveRecord::Migration[5.2]
  def change
    create_table :uploaded_checks do |t|
      t.integer :result_no
      t.integer :generate_no

      t.timestamps
    end
  end
end
