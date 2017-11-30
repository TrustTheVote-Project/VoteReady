require "administrate/base_dashboard"

class VoterRecordDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    id: Field::Number,
    user: Field::BelongsTo,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    
    previous_voter_record: Field::BelongsTo.with_options(class_name: "VoterRecord"),
    
    first_name: Field::String,
    middle_name: Field::String,
    last_name: Field::String,
    address_1: Field::String,
    address_2: Field::String,
    city: Field::String,
    state: Field::String,
    zip: Field::String,
    
    mailing_address_1: Field::String,
    mailing_address_2: Field::String,
    mailing_city: Field::String,
    mailing_state: Field::String,
    mailing_zip: Field::String,
    
    
    
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :user,
    :previous_voter_record,
    :created_at
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :user,
    :previous_voter_record,
    :first_name,
    :middle_name,
    :last_name,
    :address_1,
    :address_2,
    :city,
    :state,
    :zip,
    :mailing_address_1,
    :mailing_address_2,
    :mailing_city,
    :mailing_state,
    :mailing_zip,
    :created_at,
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    # :email,
    # :encrypted_password,
    # :reset_password_token,
    # :reset_password_sent_at,
    # :remember_created_at,
    # :sign_in_count,
    # :current_sign_in_at,
    # :last_sign_in_at,
    # :current_sign_in_ip,
    # :last_sign_in_ip,
    # :name,
    # :role,
  ].freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
