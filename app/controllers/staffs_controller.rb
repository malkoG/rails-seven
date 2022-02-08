class StaffsController < ActionController::Base
  before_action :authenticate_admin_user!
  before_action :check_access, only: :index

  layout "dashboard"

  rescue_from ActiveRecord::RecordNotFound, with: :not_found if Rails.env.production?

  def index
    @header = "staffs/header"
    session[:staff_header] = "jeonghan"
    @users = User.order(created_at: :desc).limit(10)
  end

  protected

    def not_found
      render file: Rails.root.join("public", "404.html"), layout: "welcome", status: :not_found
    end

    def check_access
      redirect_to login_path unless admin_user_signed_in?
    end

    def filter_column
      return {} if params[:q].nil?
      params[:q]
    end

    def filter_scope
      return {} if params[:scope].nil?
      @scope = params[:scope]
    end
end
