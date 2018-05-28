class LoginAdressIpServices
  include ActiveModel::Validations

  attr_accessor :user_id, :author_ip, :login

  def initialize(user_id, author_ip)
    @user_id = user_id
    @author_ip = author_ip
    @login = User.find(user_id).login
  end

  def self.unique_validator(user_id, author_ip)
    LoginIp.find_by(user_id: user_id, author_ip: author_ip).nil?
  end

  def save
    LoginIp.create(login: login, author_ip: author_ip, user_id: user_id)
  end

  def self.login_address_list
    LoginIp.select(:login, :author_ip).as_json(only: [:login, :author_ip])
  end
end