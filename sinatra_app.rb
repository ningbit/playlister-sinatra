require 'sinatra/base'
require 'debugger'
require 'youtube_search'
require_relative './lib/models/artist.rb'
require_relative './lib/models/genre.rb'
require_relative './lib/models/song.rb'
require_relative './lib/models/library_parser.rb'




class PlaylisterApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :'home'
  end

  get '/artists' do
    @artists = Artist.all
    erb :'artists'
  end

  get '/artists/:name' do
    debugger
    @artist = Artist.find_by_name(params[:name].gsub("_"," "))
    erb :'/artists/artist'
  end

  get '/songs' do
    @songs = Song.all
    erb :'/songs'
  end

  get '/songs/:name' do
    @song = Song.find_by_name(params[:name].gsub("_"," "))
    erb :'/songs/song'
  end

  get '/genres' do
    @genres = Genre.all
    erb :'/genres'
  end
end