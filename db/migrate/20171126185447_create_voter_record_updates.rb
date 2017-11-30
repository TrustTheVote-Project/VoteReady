class CreateVoterRecordUpdates < ActiveRecord::Migration[5.1]
  def change
    create_table :voter_record_updates do |t|
      t.integer :user_id
      t.text :changed_data
      t.string :update_type
      t.timestamps
    end
  end
end
