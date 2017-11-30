class VoterRecordUpdate < ApplicationRecord
  belongs_to :user
  serialize :changed_data, Array #Attr name, old value, new value
  
  REGISTRATION_UPDATE = 'registration_update'.freeze
  
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
    
  after_create :notify_user
  
  def messages
    changed_data.collect {|change| "Changed #{VoterRecord.human_attribute_name(change[0])} from \"#{change[1]}\" to \"#{change[2]}\""}
  end
  
  
  def self.record!(user, old_record, new_record)
    changed_data = []
    CHANGEABLE_ATTRIBUTES.each do |a|
      if old_record.send(a).to_s != new_record.send(a).to_s
        changed_data << [a, old_record.send(a).to_s, new_record.send(a.to_s)]
      end
    end
    if changed_data.any?
      self.create!(
        user: user,
        update_type: VoterRecordUpdate::REGISTRATION_UPDATE, 
        changed_data: changed_data
        )
    end        
  end
  
  def notify_user
    self.user.notify(self)    
  end

  
end
