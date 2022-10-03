# file: app.rb

# require_relative './lib/album_repository'
require_relative './lib/artist_repository'
require_relative './lib/album_repository'
require_relative './lib/database_connection'


class Application
  # The Application class initializer
  # takes four arguments:
  #  * The database name to call `DatabaseConnection.connect`
  #  * the Kernel object as `io` (so we can mock the IO in our tests)
  #  * the AlbumRepository object (or a double of it)
  #  * the ArtistRepository object (or a double of it)
  def initialize(database_name, io, album_repository, artist_repository)
    DatabaseConnection.connect(database_name)
    @io = io
    @album_repository = album_repository
    @artist_repository = artist_repository
  end

  def run
    @io.puts 'What would you like to do? '
    @io.puts '1 - List all albums'
    @io.puts '2 - List all artists'
    choice = @io.gets.chomp
    if choice == '1'
      num = 1
      all = @album_repository.all
      all.each do |album|
        @io.puts "* #{num} - #{album.title}"
        num += 1
      end
    elsif choice == '2'
      num = 1
      all = @artist_repository.all
      all.each do |artist|
        @io.puts "* #{num} - #{artist.name}"
        num += 1
      end
    else
      @io.puts 'Incorrect command'
    end
    # "Runs" the terminal application
    # so it can ask the user to enter some input
    # and then decide to run the appropriate action
    # or behaviour.

    # Use `@io.puts` or `@io.gets` to
    # write output and ask for user input.
  end
end

# Don't worry too much about this if statement. It is basically saying "only
# run the following code if this is the main file being run, instead of having
# been required or loaded by another file.
# If you want to learn more about __FILE__ and $0, see here: https://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Variables_and_Constants#Pre-defined_Variables
# if __FILE__ == $0
#   app = Application.new(
#     'music_library',
#     Kernel,
#     ArtistRepository.new
#   )
#   app.run
# end
artists = ArtistRepository.new
albums = AlbumRepository.new
new = Application.new('music_library_test', Kernel, albums, artists)
new.run