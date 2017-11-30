class UsersController < ApplicationController
  before_action :authenticate_user!, :set_user
  def show
    
  end
  
  def welcome
  end
  
  protected
  def set_user
    @user = current_user
  end
  
end
