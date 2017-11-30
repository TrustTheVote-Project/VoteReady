require "administrate/field/base"

class ListField < Administrate::Field::Base
  
  def to_s
    data
  end
end
