module ApplicationHelper
  def flash_class(level)
    case level
    when "success" then "ui success message"
    when "danger" then "ui error message"
    end
  end
end
