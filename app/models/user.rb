class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  validates_presence_of :first_name, :last_name, :date_of_birth

  has_many :voter_records #, order: "created at DESC"
  has_many :voter_record_updates

  after_create :get_current_voter_record
  
  
  def get_current_voter_record
    VoterRecord.create_random!(self)
  end
  
  def latest_voter_record
    voter_records.last
  end
  
  def simulate_voter_record_change
    last_vr = latest_voter_record
    new_vr = last_vr.dup
    new_vr.previous_voter_record = last_vr
    if (rand(2)==1)
      #update a city
      new_vr.city = "City #{rand(100)}"
    else
      #update a name
      new_vr.first_name = "New Name#{rand(100)}"
    end
    new_vr.save!
  end
  
  def notify_registration_update(changed_data)
    voter_record_updates.create(update_type: VoterRecordUpdate::REGISTRATION_UPDATE, changed_data: changed_data)
    
  end
  
end
