ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'sinatra/flash'
require_relative 'models/data_mapper_setup'
#require './app/models/link'

class Bookmark < Sinatra::Base
  enable :sessions
  set :session_secret, 'super secret'

  register Sinatra::Flash

  helpers do
    def current_user
     @current_user ||= User.get(session[:user_id])
    end
  end

  get '/' do
    'Hello Bookmark!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  get '/links/new' do
    erb :'links/new'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    #tag = Tag.create(name: params[:tags])
    #link.tags << tag
    link.save
    redirect to('/links')
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
      erb :'users/new'
  end

  post '/users' do
    user = User.new(email: params[:email],
                password: params[:password],
                password_confirmation: params[:password_confirmation])
    if user.save
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:notice] = "Password and confirmation password do not match"
      erb :'users/new'
  end
end

  get '/links/tags' do
    @tags = Tag.all
    erb :'links/tags'
  end




  # start the server if ruby file executed directly
  run! if app_file == $0
end
