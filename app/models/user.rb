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
  attr_accessible :email, :name

  validates :name, presence: true, length: { maximum: 32}

  EMAIL_REGEXP = /^[\w]+[\+\.\-\w]*+@[a-z\d\-.]+\.[a-z]+$/i
  validates :email, presence: true, format: { with: EMAIL_REGEXP },
      uniqueness: { case_sensitive: false }

  before_save do |user|
   user.email = email.downcase 
  end
end
