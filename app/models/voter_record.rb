class VoterRecord < ApplicationRecord
  belongs_to :user
  belongs_to :previous_voter_record, class_name: "VoterRecord", required: false
  
  after_create :detect_change
  
  CHANGEABLE_ATTRIBUTES = %w(
    first_name 
    middle_name
    last_name
    address_1
    address_2
    city
    zip
    state
    date_of_birth    
  ) #TODO: There are more here
    
  
  
  
  def self.create_random!(user)
    self.create!({
      first_name: user.first_name,
      last_name: user.last_name,
      address_1: user.address_1,
      address_2: user.address_2,
      city: user.city,
      zip: user.zip,
      state: user.state,
      date_of_birth: user.date_of_birth,
      user: user
    })
  end
  
  def detect_change
    pv = previous_voter_record
    if !pv && self.user
      pv = self.user.latest_voter_record
    end
    if pv && pv != self
      changed_data = []
      CHANGEABLE_ATTRIBUTES.each do |a|
        if pv.send(a).to_s != self.send(a).to_s
          changed_data << [a, pv.send(a).to_s, self.send(a.to_s)]
        end
      end
      if changed_data.any?
        user.notify_registration_update(changed_data)
      end
    end
  end
  
end
