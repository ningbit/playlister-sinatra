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

  get '/search' do
    @search = params[:search]
    @artists = Artist.search_by_first_char(@search)
    @songs = Song.search_by_first_char(@search)
    @artists.concat Artist.search_by_string(@search) if @search.size > 1
    @songs.concat Song.search_by_string(@search) if @search.size > 1
    erb :'/search'
  end

  get '/random' do
    @song = Song.random
    erb :'/songs/song'
  end

  get '/artists/add' do
    erb :'/edit/add'
  end

  get '/artists/drop' do
    erb :'/edit/drop'
  end

  get '/songs/add' do
    erb :'/edit/add'
  end

  get '/songs/drop' do
    erb :'/edit/drop'
  end

  post '/edit/confirmation' do
    if params[:name].size != 0 && params[:song].size != 0
      artist = Artist.new
      song = Song.new
      genre = Genre.find_by_name(params[:genre])
      artist.name = params[:name]
      song.name = params[:song]
      song.genre = genre
      artist.add_song(song)
      @artist = artist
    else
      @artist = nil
    end
    debugger
    erb :'/edit/confirmation'
  end

  get '/artists' do
    @artists = Artist.all
    erb :'/artists/artists'
  end

  get '/artists/:name' do
    @artist = Artist.find_by_name(params[:name].gsub("_"," "))
    erb :'/artists/artist'
  end

  get '/songs' do
    @songs = Song.all.sort_by { |e| e.name }
    erb :'/songs/songs'
  end

  get '/songs/:name' do
    song_name = params[:name]
    @song = Song.find_by_name(params[:name].split("_-_").last.gsub("_"," "))
    erb :'/songs/song'
  end

  get '/genres' do
    @genres = Genre.all
    erb :'/genres/genres'
  end

  get '/genres/:name' do
    @genre = Genre.find_by_name(params[:name].gsub("_"," "))
    erb :'/genres/genre'
  end

end