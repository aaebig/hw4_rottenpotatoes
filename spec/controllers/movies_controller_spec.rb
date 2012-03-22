require 'spec_helper'

describe MoviesController do
  describe 'Find with same director' do
    before :each do
      @fake_results = [mock('Movie'), mock('Movie')]
    end
    it 'should call the model method that finds by same director' do
      Movie.should_receive(:find_same_director).with('1').and_return(@fake_results)
      get :find_same_director, {:id => "1"}
    end
    describe 'after invalid search' do
      before :each do
        Movie.stub(:find_same_director).and_raise(Movie::MissingDirector.new("'Alien' has no director info"))
        get :find_same_director, {:id => "1"}
      end
      it 'should set the flash notice if there is an error' do
        flash[:warning].should == "'Alien' has no director info"
      end
      it 'should select the index template for rendering' do
        response.should redirect_to(movies_path)
      end
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_same_director).and_return(@fake_results)
        get :find_same_director, {:id => "1"}
      end
      it 'should select the Similar movies template for rendering' do
        response.should render_template('find_same_director')
      end
      it 'should make the movies available in the template' do
        assigns(:movies).should == @fake_results
      end
    end
  end
end
