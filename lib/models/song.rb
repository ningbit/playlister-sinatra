require_relative '../concerns/memorable'
require_relative '../concerns/listable'
require_relative '../concerns/findable'
require_relative '../concerns/sluggable'
require_relative '../concerns/searchable'


class Song
  attr_accessor :artist, :genre, :name

  extend Memorable::ClassMethods
  include Memorable::InstanceMethods

  extend Sluggable::ClassMethods
  include Sluggable::InstanceMethods

  extend Listable
  extend Findable
  extend Searchable

  reset_all

  def url
    "#{self.name}.html"
  end

  def self.action(index)
    self.all[index-1].play
  end

  def play
    puts "playing #{self.title}, enjoy!"
  end

  def title
    "#{self.artist.name} - #{self.name} [#{self.genre.name}]"
  end

  def genre=(genre)
    @genre = genre
    genre.songs << self
  end

  def to_param
    self.slug
  end

end
