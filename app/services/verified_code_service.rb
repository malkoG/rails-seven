class VerifiedCodeService
  attr_reader :phone

  def initialize(phone)
    @phone = phone
  end

  def created_code
    attributes = { phone: phone, code: random_code }
    code = VerifiedCode.create!(attributes)
    code
  end

  def verifying(code)
    result = false
    result = true if latest_code.code == code
    result
  end

  def latest_code
    code = VerifiedCode.where(phone: phone).last
    code
  end

  private

  def random_code
    code = ""
    6.times do
      code << %w[2 4 6 8 0].sample
    end
    code
  end
end