1. Design and create the Table


2. Create Test SQL seeds

TRUNCATE TABLE artists RESTART IDENTITY;

INSERT INTO artists (name, genre) VALUES('Pixies', 'Rock');
INSERT INTO artists (name, genre) VALUES('ABBA', 'Pop');


3. Define the class names

#Model class
class Artist
end

#repositoryclass
class ArtistRepository
end



4. Implement the Model class

class Artist
  attr_accessor :id, :name, :genre
end


5. Define the Repository Class interface

class ArtistRepository
  def all
    #SELECT id, name, genre FROM artists;
    #returns array of Artist objects
  end

  def find(id)
    #SELECT id, name, genre FROM artists WHERE id = $1
  end

  def create(artist)
    #INSERT INTO artists (name, genre) VALUES ($1, $2)
  end

  def delete(id)
    # DELETE FROM artists WHERE id = $1;
  end

  def update(artist)
    #UPDATE artists SET Name = $1, genre = $2 WHERE id = $3;
  end

end


6. Write Test Examples

#get all students

repo = ArtistRepository.new

artists = repo.all
artists.length # => 2
artists.first.id # => '1'
artists.find.name # => 'Pixies'

repo = ArtistRepository.new

artist - repo.find(1)
artist.name # => 'Pixies'
artist.genre # => 'Rock'


#create a new artist

repo - ArtistRepository.new

artist = Artist.new
artist.name = 'Beatles'
artist.genre = 'Pop'

repo.create(artist)


7. Reload the SQL seeds before each test run


8. Test-drive and implement the Repository class behaviour

