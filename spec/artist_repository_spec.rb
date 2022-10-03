require 'artist_repository'
require 'database_connection'

DatabaseConnection.connect('music_library_test')

RSpec.describe ArtistRepository do
    def reset_artists_table
        seed_sql = File.read('spec/seeds_artists.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', user: 'postgres', password: '12345'}) #what's the difference between this and 
        connection.exec(seed_sql)
    end

    before(:each) do
      reset_artists_table
    end

    it 'testing all method' do
        repo = ArtistRepository.new
        artists = repo.all
        expect(artists.length).to eq (2)
        expect(artists.first.id).to eq ('1')
        expect(artists.first.name).to eq ('Pixies')
    end

    it 'returns Abba as single artist' do
        repo = ArtistRepository.new
        artist = repo.find(2)
        expect(artist.name).to eq 'ABBA'
        expect(artist.genre).to eq 'Pop'
    end

    it 'returns Pixies as single artist' do
        repo = ArtistRepository.new
        artist = repo.find(1)
        expect(artist.name).to eq 'Pixies'
        expect(artist.genre).to eq 'Rock'
    end

    it 'testing create method using all method' do
        repo = ArtistRepository.new
        artist = Artist.new
        artist.name = 'Beatles'
        artist.genre = 'Pop'
        repo.create(artist)
        artists = repo.all
        last_artist = artists.last

        expect(last_artist.name).to eq 'Beatles'
        expect(last_artist.genre).to eq 'Pop'
    end
    
    it 'testing delete method' do
        repo = ArtistRepository.new
        repo.delete(1)
        all_artists = repo.all
        expect(all_artists.length).to eq 1
        expect(all_artists.first.id).to eq '2'

    end
    it 'deletes 2 artists' do
        repo = ArtistRepository.new
        repo.delete(1)
        repo.delete(2)
        all_artists = repo.all
        expect(all_artists.length).to eq 0

    end
    it 'updates the artist with new values' do
      repo = ArtistRepository.new
      artist = repo.find(1)
      artist.name = 'Something else' #how does this work
      artist.genre = 'Disco'
      repo.update(artist)
      updated_artist = repo.find(1)
      expect(updated_artist.name).to eq 'Something else'
      expect(updated_artist.genre).to eq 'Disco'

    end

    it 'finds the artist with related albums' do
        repo = ArtistRepository.new
        artist = repo.find_with_albums(1)
        expect(artist.name).to eq 'Pixies'
        expect(artist.genre).to eq 'Rock'
        expect(artist.albums.length).to eq 2
        expect(artist.albums.first.title).to eq 'Bossonova'
    end

    




end