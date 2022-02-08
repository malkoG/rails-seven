class Staffs::AdminUsersController < StaffsController
  before_action :set_admin_user, only: %I[show edit update destroy]
  before_action :load_comments, only: %I[show]

  def index
    @filter_attributes = ["id", "email"]
    @column_attributes = ["id", "email", "created_at", "updated_at", "current_sign_in_at", "sign_in_count", "last_sign_in_at", "current_sign_in_ip", "last_sign_in_ip"]

    query_result = AdminUserRepository.admin_search(params)
    @q, @admin_users = query_result.values_at(:q, :result)
  end

  def new
    @admin_user = AdminUser.new
  end

  def create
    @admin_user = AdminUser.new(admin_user_params)
    @admin_user.save

    redirect_to staffs_admin_users_path
  end

  def show
    @comment = ActiveAdmin::Comment.new
  end

  def edit
  end

  def update
    @admin_user.update(admin_user_params)
    redirect_to staffs_admin_users_path
  end

  def destroy
    @admin_user.destroy

    redirect_to staffs_admin_users_path
  end

  private
    def set_admin_user
      @admin_user = AdminUser.find params[:id]
    end

    def admin_user_params
      params.require(:admin_user).permit(:email, :password, :password_confirmation)
    end

    def load_comments
      set_admin_user
      @comments = ActiveAdmin::Comment.where(resource_type: "AdminUser", resource_id: @admin_user.id).order("id asc")
    end
end
