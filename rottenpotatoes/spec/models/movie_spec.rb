require 'rails_helper'
describe Movie do
  describe '.find_similar_movies' do

    movie1 = Movie.create(:title=>"movie1")
    movie2 = Movie.create(:title=>'movie2',:director=>'dir1')
    movie3 = Movie.create(:title=>'movie3',:director=>'dir1')

    context 'director does not exist' do
        it 'handles sad path' do
          expect(Movie.similar_movies(movie1.title)).to eql(nil)
        end
    end

    context 'director exists' do
      it 'find similar movies' do
        expect(Movie.similar_movies(movie2.title)).eql?(['movie2','movie3'])
      end
    end
  end
end