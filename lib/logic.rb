require_relative '../lib/books'
require 'nokogiri'
require 'httparty'

class Logic
  attr_reader :current_reader

  VALIDGENRES = ['travel', 'mystery', 'historical fiction', 'sequential art',
                 'classics', 'philosophy', 'romance', 'womens fiction',
                 'fiction', 'childrens', 'religion', 'nonfiction', 'music',
                 'default', 'science fiction',
                 'sports and games', 'add a comment', 'fantasy', 'new adult',
                 'young adult', 'science', 'poetry', 'paranormal',
                 'art', 'psychology',
                 'autobiography', 'parenting', 'adult fiction', 'humor',
                 'horror',
                 'history', 'food and drink', 'christian fiction',
                 'business',
                 'biography', 'thriller', 'contemporary',
                 'spirituality', 'academic',
                 'self help', 'historical', 'christian', 'suspense',
                 'short stories', 'novels', 'health', 'politics', 'cultural',
                 'erotica', 'crime'].freeze

  def initialize(current_reader)
    @reader = current_reader
  end

  def valid_genre?(input_genre)
    VALIDGENRES.include?(input_genre)
  end

  def genre_index(input_genre)
    VALIDGENRES.index(input_genre).to_i + 2
  end

  def book_url(input_genre, index)
    input_string = input_genre.downcase.gsub(/\s/, '-')
    index_string = index.to_s
    "https://books.toscrape.com/catalogue/category/books/#{input_string}_#{index_string}/index.html"
  end

  def search(url)
    unparsed_page = HTTParty.get(url)
    parse_page = Nokogiri::HTML(unparsed_page.body)
    books = parse_page.css('article.product_pod')
    arr = []
    books.each do |book|
      books = Books.new
      books.title = book.css('h3').text
      books.price = book.css('p.price_color').text
      arr.push(books)
    end
    arr
  end
end
