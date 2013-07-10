# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :email, :name, :password, :password_confirmation

  validates :name, presence: true, length: { maximum: 32}

  EMAIL_REGEXP = /^[\w]+[\+\.\-\w]*+@[a-z\d\-.]+\.[a-z]+$/i
  validates :email, presence: true, format: { with: EMAIL_REGEXP },
      uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 } 
  validates_confirmation_of :password

  validates :password_confirmation, presence: true

  before_save do |user|
   user.email = email.downcase 
  end

  protected

  def verify_image
    # For issue #5 and issue #3
    true
  end
end
