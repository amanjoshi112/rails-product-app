class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy

  attr_accessor :password
  before_save :prepare_password

  #validates_presence_of :username
  validates_uniqueness_of :email, allow_blank: true
  # validates_format_of :username, with: /\A[@\w\-\.]+\z/,
  #                                allow_blank: true,
  #                                message: "should only contain letters, numbers, or .-_@"
  validates_format_of :email, with: /\A[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}\z/i
  validates_presence_of :password, on: :create
  validates_confirmation_of :password
  validates_length_of :password, minimum: 4, allow_blank: true

  # login can be either username or email address
  def self.authenticate(login, pass)
     user = find_by_email(login)
     return user if user && pass
  end

  # def matching_password?(pass)
  #   pass == encrypted_password
  # end

  #private

  # def prepare_password
  #   unless password.blank?
  #     self.password_salt = Digest::SHA1.hexdigest([Time.now, rand].join)
  #     self.password = encrypt_password(password)
  #   end
  # end

  # def encrypt_password(pass)
  #   Digest::SHA1.hexdigest([pass, password_salt].join)
  #   self.password = encrypt_password(password)
  # end

end
