require 'rails_helper'
describe MoviesController do
  describe "test show" do
    it "test get movie's detail" do
      movie = Movie.find_by 1
      get :show, id: 1
      expect(assigns(:movie)).to eql(movie)
    end
  end

  describe "test index" do
    it 'should render the index template' do
      get :index
      expect(response).to render_template('index')
      end
  end

  describe "test new" do
    it 'should render the new template' do
      get :new
      expect(response).to render_template('new')
    end
  end

  describe "test create" do
    it 'create new movie' do
      prev_cnt = Movie.count
      movie = Movie.new
      movie.title = "Test"
      movie.rating = "G"
      movie.description = 'None'
      post :create, :movie=>movie.as_json
      expect(prev_cnt).eql?(Movie.count-1)
    end
  end

  describe "test edit" do
    movie = Movie.find_by 1
    before do
      get :edit, id: movie.id
    end

    it 'should find the movie' do
      expect(assigns(:movie)).to eql(movie)
    end

    it 'should render the edit template' do
      expect(response).to render_template('edit')
    end
  end

  describe "test update" do
    movie1 = Movie.find_by 2
    before(:each) do
      movie1.title = 'Modified'
      put :update, :id=>movie1.id, :movie=>movie1.as_json
    end

    it 'updates an existing movie' do
      movie1.reload
      expect(movie1.title).to eql('Modified')
    end

    it 'redirects to the movie page' do
      expect(response).to redirect_to(movie_path(movie1.id))
    end
  end

  describe "test destroy" do
    movie = Movie.find_by 1
    it "destroys a movie" do
      prevcnt = Movie.count
      delete :destroy, id:movie.id
      expect(prevcnt).eql?(Movie.count+1)
    end
  end

  describe "test search" do
    it 'should call Movie.similar_movies' do
      expect(Movie).to receive(:similar_movies).with('Aladdin')
      get :search, { title: 'Aladdin' }
    end
    it 'should assign similar movies if director exists' do
      movies = ['Seven', 'The Social Network']
      Movie.stub(:similar_movies).with('Seven').and_return(movies)
      get :search, { title: 'Seven' }
      expect(assigns(:similar_movies)).to eql(movies)
    end
    it "should redirect to home page if director isn't known" do
      Movie.stub(:similar_movies).with('No name').and_return(nil)
      get :search, { title: 'No name' }
      expect(response).to redirect_to(root_url)
    end
  end
end