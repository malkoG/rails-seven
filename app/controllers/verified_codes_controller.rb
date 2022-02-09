class VerifiedCodesController < ApplicationController
  def edit
  end

  def new
    phone = params[:phone]
    @petition = Petition.new(phone: phone)
  end

  def create
    file = File.read('solapi-config.json')
    config = JSON.parse(file)
    phone = verified_code_params[:phone]
    service = VerifiedCodeService.new(phone)
    code = service.created_code
    option = {country: "82", to: phone, from: config['from'], text: "테스트메세지#{code}",}
    pp option
    Message.send_one(option)
  end

  def index
  end

  private

  def verified_code_params
    params.require(:verified_code).permit(:phone)
  end
end
