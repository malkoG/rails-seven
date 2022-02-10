require "test_helper"

class NameMaskServiceTest < ActiveSupport::TestCase
  test "the truth" do
    service_1=NameMaskService.new("안녕")
    pp service_1.masked_name
    service_2=NameMaskService.new("하세요")
    pp service_2.masked_name
    service_3=NameMaskService.new("반가워요")
    pp service_3.masked_name
    service_4=NameMaskService.new("잘있어요")
    pp service_4.masked_name
    service_5=NameMaskService.new("다시만나요")
    pp service_5.masked_name
    assert true
  end
end
