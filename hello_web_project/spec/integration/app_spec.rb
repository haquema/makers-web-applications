require 'spec_helper'
require 'rack/test'
require_relative '../../app'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  context "GET /hello" do
    it "returns 200 OK" do
      response = get('/hello')
      expect(response.status).to eq(200)
    end

    it "contains a h1 title" do
      response = get('/hello')
      expect(response.body).to include("<h1>Hello!</h1>")
    end
  end

  context "GET /names" do
    it 'returns 200 OK and a list of names' do
      response = get('/names')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Julia, Mary, Karim")
    end
  end

  context "POST /sort-names" do
    it 'returns 200 OK and a string of sorted names passed as body parameters' do
      response = post('/sort-names?names=Joe,Alice,Zoe,Julia,Kieran')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Alice,Joe,Julia,Kieran,Zoe")
    end
  
    xit 'returns 200 OK' do
      response = post('/sort-names?names=Sami,Emad,Aziz')

      expect(response.status).to eq(200)
      expect(response.body).to eq("Aziz,Emad,Sami")
    end
  end

end