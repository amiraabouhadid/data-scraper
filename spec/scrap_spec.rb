require_relative '../lib/books'
require_relative '../lib/logic'

current_reader = 'amira'
logic = Logic.new(current_reader)

describe Logic do
  describe '#valid_genre?' do
    it 'returns true or false' do
      expect(logic.valid_genre?('fiction')).to eql(true)
      expect(logic.valid_genre?('*afsas')).to eql(false)
      expect(logic.valid_genre?('self help')).to eql(true)
      expect(logic.valid_genre?(123)).to eql(false)
      expect(logic.valid_genre?([983])).to eql(false)
    end
  end
  describe '#genre_index' do
    it 'returns integer' do
      expect(logic.genre_index('travel')).to eql(2)
      expect(logic.genre_index('historical fiction')).to eql(4)
      expect(logic.genre_index('add a comment')).to eql(18)
    end
  end
  describe '#book_url' do
    it 'returns string' do
      expect(logic.book_url('travel',
                            2)).to eql('https://books.toscrape.com/catalogue/category/books/travel_2/index.html')
      expect(logic.book_url('historical fiction',
                            4)).to eql('https://books.toscrape.com/catalogue/category/books/historical-fiction_4/index.html')
      expect(logic.book_url('add a comment',
                            18)).to eql('https://books.toscrape.com/catalogue/category/books/add-a-comment_18/index.html')
    end
  end
end
