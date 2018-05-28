require 'resolv'

class UsersPostServices
  include ActiveModel::Validations

  attr_accessor :login, :title, :message, :author_ip

  validates :login, :title, :message, presence: true
  validates :author_ip, presence: true,
            format: { with: Resolv::IPv4::Regex }

  def initialize(params)
    @title = params[:title]
    @login = params[:login]
    @message = params[:message]
    @author_ip = params[:author_ip]
  end

  def save
    user = User.find_or_create_by(login: login)
    user.blog_posts.create(title: title, message: message, author_ip: author_ip)
    write_the_same_ip(user.id)
  end

  def write_the_same_ip(user_id)
    login_author_ip = BlogPost.where(author_ip: author_ip).where.not(user_id: user_id).first
    if login_author_ip
      if LoginAdressIpServices.unique_validator(user_id, login_author_ip.author_ip)
        first_login_adress = LoginAdressIpServices.new(user_id,login_author_ip.author_ip)
        first_login_adress.save
      end
      if LoginAdressIpServices.unique_validator(login_author_ip.user_id, login_author_ip.author_ip)
        second_login_adress = LoginAdressIpServices.new(login_author_ip.user_id,login_author_ip.author_ip)
        second_login_adress.save
      end
    end
  end

  def self.login_address_list
    LoginAdressIpServices.login_address_list
  end
end
