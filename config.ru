require 'bundler/setup'
require 'sinatra/base'
require 'sinatra/reloader'
require 'youtube_search'

require './environment'

parser = LibraryParser.new('/Users/nyap/Dropbox/Flatiron School/Day_18/playlister-sinatra/data')
parser.call

require './sinatra_app'

run PlaylisterApp.new
