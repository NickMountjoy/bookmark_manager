ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'models/data_mapper_setup'
#require './app/models/link'

class Bookmark < Sinatra::Base

  get '/new' do
    'Hello Bookmark!'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    tag = Tag.create(name: params[:tags])
    link.tags << tag
    link.save
    redirect '/links'
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/links/tags' do
    @tags = Tag.all
    erb :'links/tags'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
