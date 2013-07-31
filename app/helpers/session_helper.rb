module SessionHelper
  def sign_in(user)
    token = User.new_remember_token
    user.update_attribute(:remember_token, User.encrypt(token))
    cookies.permanent[:remember_token] = token
	# User.encrypt(remember_token)
    self.current_user = user
  end
  def current_user=(user)
    @current_user = user
  end
  def current_user
    token = User.encrypt(cookies[:remember_token])
    @current_user = User.find_by_remember_token(token) 
  end
  def sign_in? 
    !self.current_user.nil?
  end
  def sign_out
    self.current_user = nil
    cookies.delete(:remember_token)
  end
end
