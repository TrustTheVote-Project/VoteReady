class CreateVoterRecords < ActiveRecord::Migration[5.1]
  def change
    create_table :voter_records do |t|
      t.integer :previous_voter_record_id
      t.integer :user_id
      
      t.string :state_record_identifier
      
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :state
      t.string :zip
      
      t.string :mailing_address_1
      t.string :mailing_address_2
      t.string :mailing_city
      t.string :mailing_state
      t.string :mailing_zip
      
      t.string :phone
      t.string :email
      t.string :status
      t.string :language
      t.boolean :vote_by_mail
      

      t.date :date_of_birth
      
      t.timestamps
    end
    
    add_index :voter_records, :previous_voter_record_id
    add_index :voter_records, :user_id
  end
  
end
