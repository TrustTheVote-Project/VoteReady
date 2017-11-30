class VoterRecordUpdatesController < ApplicationController
  
  def show
    @update = VoterRecordUpdate.find(params[:id])
    @user = @update.user
    # @hide_nav = true # TODO: only hide nav if we're coming from an alert? (or show it if already logged in)
  end
  
end
