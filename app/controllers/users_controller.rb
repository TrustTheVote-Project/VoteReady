class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user
  
  def show
    @vr = @user.latest_voter_record
  end
  
  def history
    @updates = @user.voter_record_updates
  end
  
  def edit
  end
  
  def welcome
  end
  
  protected
  def set_user
    @user = current_user
  end
  
end
