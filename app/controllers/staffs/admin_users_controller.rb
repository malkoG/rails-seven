class Staffs::AdminUsersController < StaffsController
  before_action :set_admin_user, only: %I[show edit update destroy]
  before_action :load_comments, only: %I[show]

  def index
    @filter_attributes = ["id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at"]
    @column_attributes = ["id", "email", "encrypted_password", "reset_password_token", "reset_password_sent_at", "remember_created_at", "created_at", "updated_at"]

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
      params.require(:admin_user).permit(:id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :created_at, :updated_at)
    end

    def load_comments
      set_admin_user
      @comments = ActiveAdmin::Comment.where(resource_type: "AdminUser", resource_id: @admin_user.id).order("id asc")
    end
end
