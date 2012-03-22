class Movie < ActiveRecord::Base
  
  class Movie::MissingDirector < StandardError ; end

  def self.find_same_director(id)
    director = self.find(id).director
    if director.length > 0
      self.find_by_director(director)
    else
      raise Movie::MissingDirector, %Q['#{self.find(id).title}' has no director info]
    end
  end
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
end
