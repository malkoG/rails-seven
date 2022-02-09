class Staffs::PetitionsController < StaffsController
  before_action :set_petition, only: %I[show edit update destroy]
  before_action :load_comments, only: %I[show]

  def index
    @filter_attributes = ["id", "name", "birthday", "email", "phone", "code", "created_at", "updated_at"]
    @column_attributes = ["id", "name", "birthday", "email", "phone", "code", "created_at", "updated_at"]

    query_result = PetitionRepository.admin_search(params)
    @q, @petitions = query_result.values_at(:q, :result)
  end

  def new
    @petition = Petition.new
  end

  def create
    @petition = Petition.new(petition_params)
    @petition.save

    redirect_to staffs_petitions_path
  end

  def show
    @comment = ActiveAdmin::Comment.new
  end

  def edit
  end

  def update
    redirect_to staffs_petitions_path
  end

  def destroy
    @petition.destroy

    redirect_to staffs_petitions_path
  end

  private
    def set_petition
      @petition = Petition.find params[:id]
    end

    def petition_params
      params.require(:petition).permit(:id, :name, :birthday, :email, :phone, :code, :created_at, :updated_at)
    end

    def load_comments
      set_petition
      @comments = ActiveAdmin::Comment.where(resource_type: "Petition", resource_id: @petition.id).order("id asc")
    end
end
