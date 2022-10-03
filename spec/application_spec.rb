# require_relative '../lib/album_repository'
# require_relative '../lib/database_connection'
# require_relative '../lib/album'
require_relative '../application.rb'


RSpec.describe Application do
    context 'testing application' do
        it 'testing to see if all albums listed' do
            io = double :io
            album = AlbumRepository.new
            artist = ArtistRepository.new
            expect(io).to receive(:puts).with('What would you like to do? ').ordered
            expect(io).to receive(:puts).with('1 - List all albums').ordered
            expect(io).to receive(:puts).with('2 - List all artists').ordered
            expect(io).to receive(:gets).and_return('1').ordered
            expect(io).to receive(:puts).with('* 1 - Bossonova').ordered
            expect(io).to receive(:puts).with('* 2 - Surfer Ross').ordered
            database = 'music_library_test'
            application = Application.new(database, io, album, artist)
            application.run
        end
        it 'testing to see if all artists listed' do
            io = double :io
            album = AlbumRepository.new
            artist = ArtistRepository.new
            expect(io).to receive(:puts).with('What would you like to do? ').ordered
            expect(io).to receive(:puts).with('1 - List all albums').ordered
            expect(io).to receive(:puts).with('2 - List all artists').ordered
            expect(io).to receive(:gets).and_return('2').ordered
            expect(io).to receive(:puts).with('* 1 - Pixies').ordered
            expect(io).to receive(:puts).with('* 2 - ABBA').ordered
            database = 'music_library_test'
            application = Application.new(database, io, album, artist)
            application.run
        end
        it 'testing incorrect command' do
            io = double :io
            album = AlbumRepository.new
            artist = ArtistRepository.new
            expect(io).to receive(:puts).with('What would you like to do? ').ordered
            expect(io).to receive(:puts).with('1 - List all albums').ordered
            expect(io).to receive(:puts).with('2 - List all artists').ordered
            expect(io).to receive(:gets).and_return('3').ordered
            expect(io).to receive(:puts).with('Incorrect command').ordered
            database = 'music_library_test'
            application = Application.new(database, io, album, artist)
            application.run
        end
    end
end