module ApplicationHelper
  def one_line_address(u)
    [u.address_1, u.address_2, u.city, u.state, u.zip].collect do |part|
      part.blank? ? nil : part
    end.compact.join(", ")
  end
  
end
