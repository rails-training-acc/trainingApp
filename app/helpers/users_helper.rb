module UsersHelper

  def admin? 
    !self.current_user.nil? && self.current_user.admin
  end

end
