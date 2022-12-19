class CreateMedicalRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :medical_records do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :level, null: false

      t.timestamps
    end
  end
end
