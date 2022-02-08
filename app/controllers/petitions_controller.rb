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

    if service.verifying(code) == false
      flash[:error] = "인증번호를 확인해주세요"
      redirect_to(new_petition_path) and return
    end

    if @petition.save
      redirect_to(petitions_path)
    else
      flash[:error] = @petition.errors.full_messages.join(", ")
      redirect_to(new_petition_path)
    end

  end

  def index
    @petitions=Petition.all
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
