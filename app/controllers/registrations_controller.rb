class RegistrationsController < Devise::RegistrationsController
    
    

  private

  def sign_up_params
    params.require(:user).permit( :email, :password, :password_confirmation, :role_id)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :phone_number, :role_id)
  end
end