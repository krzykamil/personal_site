# frozen_string_literal: true

class PersonalSite
  hash_routes.on 'books' do |r|
    @genres = request.params['genre'].to_s.empty? ? DB.from(:books).select(:genre).map(:genre).uniq : request.params['genre'].to_s
    @books = Book.where(Sequel.lit('books.name ILIKE ? AND books.genre IN ?', "%#{request.params['search']}%",
                                   @genres)).eager_graph(:authors).map(&:to_hash)

    r.get 'list' do
      view('books/index')
    end

    r.on 'search' do
      r.is do
        r.get do
          # TODO: add filters for attributes
          # @genres = @books.map(&:genre).uniq.compact
          # @genres_size = @genres.count
          response['Content-Type'] = 'application/json'
          response['Access-Control-Allow-Origin'] = '*'
          @books.to_json
        end
      end
    end
  end
end
