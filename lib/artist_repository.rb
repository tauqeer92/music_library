require_relative './artist'

class ArtistRepository
  def all
    result_set = DatabaseConnection.exec_params('SELECT id, name, genre FROM artists;', [])
    
    artists = []
    
    result_set.each do |record| 
        artist = Artist.new
        artist.id = record['id']
        artist.name = record['name']
        artist.genre = record['genre'] 

        artists << artist
    end

    return artists
  end

  def find(id)
    sql = 'SELECT * FROM artists WHERE id = $1;'
    sql_params = [id]
    result_set = DatabaseConnection.exec_params(sql, sql_params)
    record = result_set[0]
    p result_set
    artist = Artist.new
    artist.id = record['id']
    artist.name = record['name']
    artist.genre = record['genre']

    return artist
  end

  def create(artist) #you have created an artist0
    sql = 'INSERT INTO artists (name, genre) VALUES ($1, $2);'
    sql_params = [artist.name, artist.genre]

    DatabaseConnection.exec_params(sql, sql_params)
    return nil
  end

  def delete(id)
    sql = 'DELETE FROM artists WHERE id = $1;'
    sql_params = [id]

    DatabaseConnection.exec_params(sql, sql_params)
  end

  def update(artist)
    sql = 'UPDATE artists SET name = $1, genre = $2 WHERE id = $3'
    sql_params = [artist.name, artist.genre, artist.id]

    DatabaseConnection.exec_params(sql, sql_params)

    return nil
  end

  def find_with_albums(id)
    sql = 'SELECT artists.id,
                  artists.name,
                  artists.genre,
                  albums.id AS album_id,
                  albums.title,
                  albums.release_year
          FROM artists
          JOIN albums ON albums.artist_id = artists.id
          WHERE artists.id = $1;'

    params = [id]

    result = DatabaseConnection.exec_params(sql, params)

    artist = Artist.new

    artist.id = result.first['id']
    artist.name = result.first['name']
    artist.genre = result.first['genre']
    artist.albums = []

    result.each do |record|
      album = Album.new
      album.id = record['album_id']
      album.title = record['title']
      album.release_year = record['release_year']

      artist.albums << album # we add all queried data to the album instance, then add the album instance to the artist attribute albums then return the artist
    end

    return artist
  end

end  
  


