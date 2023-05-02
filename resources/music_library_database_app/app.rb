# file: app.rb
require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end

  get '/' do
    return erb(:index)
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all

    return erb(:list_albums)
  end

  get '/albums/new' do
    return erb(:album_form)
  end

  post '/albums' do
    title = params[:title]
    release_year = params[:release_year]
    artist_id = params[:artist_id]

    album = Album.new
    album.title = title
    album.release_year = release_year
    album.artist_id = artist_id
    AlbumRepository.new.create(album)

    return erb(:album_created)
  end

  get '/albums/:id' do
    album_id = params[:id]
    album_repo = AlbumRepository.new
    artist_repo = ArtistRepository.new
    @album = album_repo.find(album_id)
    @artist = artist_repo.find(@album.artist_id)

    return erb(:album)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    
    return erb(:list_artists)
  end

  get '/artists/new' do
    return erb(:artist_form)
  end

  post '/artists' do
    name = params[:name]
    genre = params[:genre]

    artist = Artist.new
    artist.name = name
    artist.genre = genre
    ArtistRepository.new.create(artist)

    return erb(:artist_created)
  end

  get '/artists/:id' do
    id = params[:id]
    @artist = ArtistRepository.new.find(id)

    return erb(:artist)
  end

  # post '/artists' do
  #   repo = ArtistRepository.new
  #   artist = Artist.new
  #   artist.name = params[:name]
  #   artist.genre = params[:genre]
  #   repo.create(artist)
  # end

  # post '/albums' do
  #   repo = AlbumRepository.new
  #   new_album = Album.new
  #   new_album.title = params[:title]
  #   new_album.release_year = params[:release_year]
  #   new_album.artist_id = params[:artist_id]

  #   repo.create(new_album)

  #   return ''
  # end
end

