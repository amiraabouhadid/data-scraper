require_relative '../lib/books'
require_relative '../lib/logic'

current_reader = 'amira'
logic = Logic.new(current_reader)

describe Logic do
  describe '#valid_genre?' do
    it 'returns true when valid genre is entered' do
      expect(logic.valid_genre?('fiction')).to eql(true)
    end
    it 'returns false when invalid genre is entered' do
      expect(logic.valid_genre?('*afsas')).to eql(false)
    end
    it 'returns false when an integer is entered' do
      expect(logic.valid_genre?(123)).to eql(false)
    end
    it 'returns false when an array is entered' do
      expect(logic.valid_genre?([983])).to eql(false)
    end
  end
  describe '#genre_index' do
    it 'returns integer index of its respective genre' do
      expect(logic.genre_index('travel')).to eql(2)
    end
  end
  describe '#book_url' do
    it 'returns string url of its respective genre' do
      expect(logic.book_url('add a comment',
                            18)).to eql('https://books.toscrape.com/catalogue/category/books/add-a-comment_18/index.html')
    end
  end
end
