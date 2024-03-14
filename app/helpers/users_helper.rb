# frozen_string_literal: true
module UsersHelper
  
  def admin_user
    return if current_user&.role == "admin"
    
    flash[:danger] = t("application.user.is_not_admin")
    redirect_to root_path
  end
end
