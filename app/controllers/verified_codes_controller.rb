class VerifiedCodesController < ApplicationController
  def edit
  end

  def new
    phone = params[:phone]
    @petition = Petition.new(phone: phone)
  end

  def create
    phone = verified_code_params[:phone]
    service = VerifiedCodeService.new(phone)
    code = service.created_code
  end

  def index
  end

  private

  def verified_code_params
    params.require(:verified_code).permit(:phone)
  end
end
