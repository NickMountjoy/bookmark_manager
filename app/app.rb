ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require_relative 'models/data_mapper_setup'
#require './app/models/link'

class Bookmark < Sinatra::Base

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

  get '/links/tags' do
    @tags = Tag.all
    erb :'links/tags'
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
