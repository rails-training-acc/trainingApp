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

class User
  include MongoMapper::Document

  key :has_secure_password, Boolean
  key :name, String, :required => true
  key :email, String, :required => true
  key :password, String, :required => true
  key :password_confirmation, String, :required => true

  include ActiveModel::Validations
  attr_accessible :email, :name, :password, :password_confirmation

  validates :name, presence: true, length: { maximum: 32}

  EMAIL_REGEXP = /^[\w]+[\+\.\-\w]*+@[a-z\d\-.]+\.[a-z]+$/i
  validates :email, presence: true, format: { with: EMAIL_REGEXP },
      uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, complexity: true 
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
