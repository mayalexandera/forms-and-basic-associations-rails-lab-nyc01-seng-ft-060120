class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def genre_name=(name)
    self.genre = Genre.find(name: name) if Genre.find(name: name)
    self.genre = Genre.create(name: name)
  end

  def genre_name 
    self.genre ? self.genre.name : nil
  end

  def artist_name
    self.artist ? self.artist.name : nil
  end

  def artist_name=(name) 
    if Artist.find_by(name: name)
      self.artist = Artist.find_by(name: name)
    else
      self.artist = Artist.create(name: name)
    end
  end

  def note_contents=(contents)
    contents.each { |content| self.notes.build(content: content) if content.strip != ""}
  end

  def note_contents
    self.notes.map(&:content)
  end
end
