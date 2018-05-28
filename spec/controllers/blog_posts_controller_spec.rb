require 'spec_helper'
require 'rails_helper'

RSpec.describe BlogPostsController, type: :controller do

  ADRESS = '192.168.0.1'

  after(:all) do
    sql = 'TRUNCATE users CASCADE;'
    ActiveRecord::Base.connection.execute sql
    ActiveRecord::Base.connection.close
  end

  describe 'Blog post testing' do
    context 'Send post' do
      it 'status 200' do

        post :create_post, params: {title: 'test_title', message: 'test_message',
                                    login: 'test_login', author_ip: ADRESS}

        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['title']).to include('test_title')
        expect(body['login']).to include('test_login')
        expect(body['message']).to include('test_message')
        expect(body['author_ip']).to include(ADRESS)
      end

      it 'status 422 title' do
        post :create_post, params: {title: '', message: 'test_message',
                                    login: 'test_login', author_ip: ADRESS}

        expect(response).to have_http_status(422)
      end

      it 'status 422 message' do
        post :create_post, params: {title: 'test_title', message: '',
                                    login: 'test_login', author_ip: ADRESS}

        expect(response).to have_http_status(422)
      end

      it 'status 422 login' do
        post :create_post, params: {title: 'test_title', message: 'test_message',
                                    login: '', author_ip: ADRESS}

        expect(response).to have_http_status(422)
      end

      it 'status 422 author_ip' do
        post :create_post, params: {title: 'test_title', message: 'test_message',
                                    login: '', author_ip: 'like ip'}

        expect(response).to have_http_status(422)
      end
    end

    context 'Users_address_ip' do
      it 'user_ip' do
        post :create_post, params: {title: 'test_title', message: 'test_message',
                                    login: 'test_login_2', author_ip: ADRESS}
        post :create_post, params: {title: 'test_title', message: 'test_message',
                                    login: 'test_login_1', author_ip: ADRESS}
        post :users_address_ip_list
        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body[0]['login']).to include('test_login_1')
        expect(body[1]['login']).to include('test_login_2')
        expect(body[0]['author_ip']).to include(body[1]['author_ip'])
      end
    end

  end
end
