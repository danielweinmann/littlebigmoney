class RegistrationsController < Devise::RegistrationsController
  layout 'catarse_bootstrap'
 
  def create
  	super
  	session[:new_user] = true if resource.valid?
  end

end
