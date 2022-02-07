class PetitionsController < ApplicationController
  layout false
  def new
    @petition = Petition.new
    @verified_code = VerifiedCode.new
  end

  def create
    @petition = Petition.new(petition_params)
    phone = @petition.phone
    code = @petition.code
    service = VerifiedCodeService.new(phone)
   
    if service.verifying(code)
      @petition.save
    end
    redirect_to(petitions_path)
  end

  def index
  end

  def edit
    @petition
  end

  def show
  end

  private

  def petition_params
    params.require(:petition).permit(:name, :birthday, :email, :phone, :code)
  end
end
