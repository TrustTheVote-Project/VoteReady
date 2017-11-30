class VoterRecordUpdate < ApplicationRecord
  belongs_to :user
  serialize :changed_data, Array #Attr name, old value, new value
  
  REGISTRATION_UPDATE = 'registration_update'.freeze
end
