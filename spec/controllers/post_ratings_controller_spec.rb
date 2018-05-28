require 'spec_helper'
require 'rails_helper'

RSpec.describe PostRatingsController, type: :controller do

  # ADRESS = '192.168.0.1'

  before(:all) do
    user = User.create(login: 'login')
    @blog_post_1 = user.blog_posts.create(title: 'title', message: 'test_message4', author_ip: ADRESS, middle_rating: 3)
    user.blog_posts.create(title: 'title', message: 'test_message2', author_ip: ADRESS, middle_rating: 2)
    Rating.create(blog_post_id: @blog_post_1.id, rating: 3)
  end

  after(:all) do
    sql = 'TRUNCATE users CASCADE;'
    ActiveRecord::Base.connection.execute sql
    ActiveRecord::Base.connection.close
  end

  describe 'PostRatings testing' do
    context 'Put rating' do

      it 'average 5' do

        post :put_rating, params: {blog_post_id: @blog_post_1.id, rating: 5}

        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body['rating']).to eql(4)
      end

      it 'status 422 rating more than 5' do
        post :put_rating, params: {blog_post_id: @blog_post_1.id, rating: 6}

        expect(response).to have_http_status(422)
      end

      it 'status 422 rating is string' do
        post :put_rating, params: {blog_post_id: @blog_post_1.id, rating: 'rating'}

        expect(response).to have_http_status(422)
      end

      it 'status 422 rating nil' do
        post :put_rating, params: {blog_post_id: @blog_post_1.id}

        expect(response).to have_http_status(422)
      end

      it 'status 422 rating empty' do
        post :put_rating, params: {blog_post_id: @blog_post_1.id, rating: ''}

        expect(response).to have_http_status(422)
      end
    end

    context 'Check top_ratings' do
      it 'top_ratings' do
        post :top_ratings

        expect(response.content_type).to eq 'application/json'
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body)
        expect(body[0]['message']).to include('test_message4')
        expect(body[1]['message']).to include('test_message2')
      end
    end

  end
end
