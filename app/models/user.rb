require 'open-uri'
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
class ImageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if (!open(value).content_type.include? "image")
      record.errors.add attribute, (options[:message] || "is not an image")
    end
  end
end

class ComplexityValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value) 
    minSuccess  = 3 || options[:minSuccess]
    rulesPassed = 0
    special = "?<>',?[]}{=-)(_+*&^%@!$#`~{}"
    regex_special = /[#{special.gsub(/./){|char| "\\#{char}"}}]/
    regex_numeric = /[0-9]/
    regex_small = /[a-z]/
    regex_capitals = /[A-Z]/

    if value =~ regex_special 
      rulesPassed += 1
    end
    if value =~ regex_numeric 
      rulesPassed  += 1
    end
    if value =~ regex_small 
    rulesPassed += 1
    end
    if value =~ regex_capitals 
      rulesPassed += 1
    end

    if (rulesPassed < minSuccess) 
       record.errors.add attribute, (options[:message] || "is not strong password")
    end
  end
end

class User < ActiveRecord::Base
  has_secure_password

  include ActiveModel::Validations
  attr_accessible :email, :name, :password, :password_confirmation, :image_url 

  validates :name, presence: true, length: { maximum: 32}

  EMAIL_REGEXP = /^[\w]+[\+\.\-\w]*+@[a-z\d\-.]+\.[a-z]+$/i
  validates :email, presence: true, format: { with: EMAIL_REGEXP },
      uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, 
      complexity: { value: true, message: "not strong enough" } 
  validates_confirmation_of :password

  validates :password_confirmation, presence: true

  validates :image_url, :allow_blank => true, image: true

  before_save do |user|
   user.email = email.downcase
  end
  before_create :create_remember_token

  def User.new_remember_token 
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  private  
  def create_remember_token
    self.remember_token = User.new_remember_token
  end
end
