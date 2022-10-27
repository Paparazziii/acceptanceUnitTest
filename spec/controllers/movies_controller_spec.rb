require 'rails_helper'
describe MoviesController do
  describe "test show" do
    it "test get movie's detail" do
      movie = Movie.find_by 1
      get :show, id: 1
      expect(assigns(:movie)).to eql(movie)
    end
  end
end