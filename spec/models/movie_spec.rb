require 'spec_helper'

describe Movie do
  describe 'searching for movies with same director' do
    before :each do
      @fake_movie = mock('Movie')
      Movie.stub(:find).and_return(@fake_movie)
    end
    it 'should search for similar movies' do
      @fake_movie.stub(:director).and_return('George Lucas')
      Movie.should_receive(:find_all_by_director).with('George Lucas')
      Movie.find_same_director('1')
    end
    it 'should raise an error if there is no director' do
      @fake_movie.stub(:director).and_return('')
      @fake_movie.stub(:title).and_return('Star Wars')
      lambda { Movie.find_same_director('1') }.should raise_error(Movie::MissingDirector)
    end
  end
end
