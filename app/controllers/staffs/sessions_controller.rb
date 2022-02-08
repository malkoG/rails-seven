class Staffs::SessionsController < Devise::SessionsController
  layout "dashboard"

  def create
    find_admin
    redirect_to welcome_path
  end

  private
  def find_admin
    if params[:admin_user].present?
      email = params[:admin_user][:email]
      password = params[:admin_user][:password]
      admin_user = AdminUser.find_by(email: email)
      if admin_user.present? && admin_user.valid_password?(password)
        @admin_user = admin_user
        sign_in(:admin_user, @admin_user)
      else
        flash[:error] = "이메일 또는 비밀번호가 잘못되었습니다"
      end
    end
  end
end
