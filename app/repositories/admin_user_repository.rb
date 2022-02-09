# frozen_string_literal: true

class AdminUserRepository
  class << self
    def search(current_user, params)
      admin_users = current_user
        .includes([])
        .admin_users
        .order(created_at: :desc)
        .page(params[:page])
        .per(20)

      return admin_users
    end

    def admin_search(params)
      admin_users = AdminUser
        .includes([])
        .all

      filtered_params = filter_column(params)
      
      q = admin_users.ransack(filtered_params)

      admin_users = q
        .result
        .order("id desc")
        .page(params[:page])
        .per(30)

      return {
        q: q,
        result: admin_users
      }
    end

    private
      def filter_column(params)
        return {} if params[:q].nil?
        params[:q]
      end
  end
end
