class Users::RegistrationsController < Devise::RegistrationsController

  def new
    redirect_to "/"
  end

  def create
    redirect_to "/"
  end
end
