require "spec_helper"
require "rack/test"
require_relative '../../app'


describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do
    seed_sql = File.read('spec/seeds/music_library.sql')
    connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test' })
    connection.exec(seed_sql)
  end

  context "GET /albums" do
    it 'returns a list of the albums in database' do
      response = get('/albums')
      expect(response.status).to eq(200)
      expect(response.body).to include("Doolittle")
      expect(response.body).to include("Surfer Rosa")
      expect(response.body).to include("Released: 1989")
      expect(response.body).to include("Released: 1988")
    end
  end

  context "POST /albums" do
    it 'creates an album' do
      response = post('/albums', title: 'Voyage', release_year: '2022', artist_id: '2')

      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('/albums')
      
      expect(response.body).to include('Voyage')
    end
  end

  context "GET /artists" do
    it 'returns a list of the artists' do
      response = get('/artists')

      expected_response = 'Pixies, ABBA, Taylor Swift, Nina Simone'

      expect(response.status).to eq(200)
      expect(response.body).to eq(expected_response)
    end
  end

  context "POST /artists" do
    it "creates an artist entry in database" do
      response = post('/artists', name: 'Wild Nothing', genre: 'Indie')
      expect(response.status).to eq(200)
      expect(response.body).to eq('')

      response = get('artists')
      expect(response.body).to include('Wild Nothing')
    end
  end

  context "GET /albums/:id" do
    it "it returns the the Doolittle album" do
      response = get('/albums/1')

      expect(response.status).to eq (200)
      expect(response.body).to include("<h1>Doolittle</h1>")
      expect(response.body).to include("<p>Release year: 1989</p>")
      expect(response.body).to include("<p>Artist: Pixies</p>")
    end

    it "it returns the the Surfer Rosa album" do
      response = get('/albums/2')

      expect(response.status).to eq (200)
      expect(response.body).to include("<h1>Surfer Rosa</h1>")
      expect(response.body).to include("<p>Release year: 1988</p>")
      expect(response.body).to include("<p>Artist: Pixies</p>")
    end
  end
end
