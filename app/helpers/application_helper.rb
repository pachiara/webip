module ApplicationHelper
  def title
    "#{@title}"
  end

  def set_edit(user)
    if user.has_role? :admin
      return true
    elsif user.has_role? :user
      return true
    elsif user.has_role? :reader
      return false
    end
  end

  def set_manage(user)
    return (user.has_role? :admin)  ? true  : false
  end

end
