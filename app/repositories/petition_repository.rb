# frozen_string_literal: true

class PetitionRepository
  class << self
    def search(current_user, params)
      petitions = current_user
        .includes([])
        .petitions
        .order(created_at: :desc)
        .page(params[:page])
        .per(20)

      return petitions
    end

    def admin_search(params)
      petitions = Petition
        .includes([])
        .all

      filtered_params = filter_column(params)
      
      q = petitions.ransack(filtered_params)

      petitions = q
        .result
        .order("id desc")
        .page(params[:page])
        .per(30)

      return {
        q: q,
        result: petitions
      }
    end

    private
      def filter_column(params)
        return {} if params[:q].nil?
        params[:q]
      end
  end
end
