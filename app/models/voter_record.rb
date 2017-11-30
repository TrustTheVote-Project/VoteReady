class VoterRecord < ApplicationRecord
  belongs_to :user
  belongs_to :previous_voter_record, class_name: "VoterRecord", required: false
  
  after_create :detect_change
  

  
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
      email: user.email,
      phone: user.phone,
      user: user
    })
  end
  
  def detect_change
    pv = previous_voter_record
    if !pv && self.user
      pv = self.user.latest_voter_record
    end
    if pv && pv != self
      VoterRecordUpdate.record!(user, pv, self)
    end
  end
  
end
