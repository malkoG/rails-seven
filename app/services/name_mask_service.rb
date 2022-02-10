class NameMaskService
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def masked_name
    first_letter=name[0]
    last_letter=name[-1]
    if name.length == 2
      result="#{first_letter}*"
    elsif name.length >= 3
      middle=""
      (name.length-2).times do
        middle << "*"
      end
      result="#{first_letter}#{middle}#{last_letter}"
    end    
    result
  end

end 