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
  after_create :send_welcome_notification
  
  def get_current_voter_record
    # When hooked up to state systems, this will pull an initial record from those systems
    # VoterRecord.create_initial_from_state!(self)
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
  
  def send_welcome_notification
    if true || self.notification_type.to_sym == :sms
      twilio_client.api.account.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => sms_number,
          :body => I18n.t('messages.welcome.sms')
      )
    else
      # send email
    end
  end
  
  def notify(vr_update)
    notification_url = Rails.application.routes.url_helpers.voter_record_update_url(vr_update)
    if true || self.notification_type.to_sym == :sms
      twilio_client.api.account.messages.create(
          :from => "+1#{twilio_phone_number}",
          :to => sms_number,
          :body => I18n.t('messages.update.sms', notification_url: notification_url)
      )
    else
      # send email
    end
  end

  def sms_number
    self.phone.to_s.gsub(/[^\d]/, '')
  end
  
  def twilio_client
    @twilio_client ||= Twilio::REST::Client.new twilio_sid, twilio_token      
  end
  
  def twilio_sid
    @twilio_sid ||= ENV['TWILIO_SID']
  end
  
  def twilio_token
    @twilio_token ||= ENV["TWILIO_TOKEN"]
  end
  
  def twilio_phone_number 
    @twilio_phone_number ||= ENV['TWILIO_NUMBER']
  end

  
end
