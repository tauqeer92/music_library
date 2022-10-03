require_relative '../lib/album_repository'
require_relative '../lib/database_connection'
require_relative '../lib/album'

DatabaseConnection.connect('music_library_test')

RSpec.describe AlbumRepository do

    def reset_albums_table
        seed_sql = File.read('spec/seeds_albums.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'music_library_test', user: 'postgres', password: '12345'}) #what's the difference between this and 
        connection.exec(seed_sql)
    end

    before(:each) do
      reset_albums_table
    end

    it 'returns Doolittle, testing all method' do
        repo = AlbumRepository.new
        albums = repo.all
        expect(albums.length).to eq 2
        expect(albums.first.title).to eq 'Bossonova'
        expect(albums.first.artist_id).to eq '1'
    end

    it 'returns the single album Doolittle' do
        repo = AlbumRepository.new
        album = repo.find(1)
        expect(album.title).to eq 'Bossonova'
        expect(album.release_year).to eq '1999'
        expect(album.artist_id).to eq '1'
    end

    it 'returns the single album Surfer Rosa' do
        repo = AlbumRepository.new
        album = repo.find(2)
        expect(album.title).to eq 'Surfer Ross'
        expect(album.release_year).to eq '2001'
        expect(album.artist_id).to eq '1'
    end

    

end