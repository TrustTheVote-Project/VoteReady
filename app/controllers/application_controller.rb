class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  before_action :redirect_to_ttv
  
  protected
  def redirect_to_ttv
    redirect_to "https://trustthevote.org/voteready/" and return unless request.host.include?("demo.voteready.org")
    if !request.ssl?
      flash.keep
      url = URI.parse(request.url)
      url.scheme = "https"
      redirect_to(url.to_s)
    end    
  end
  
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  
end
