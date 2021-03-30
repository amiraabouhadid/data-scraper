require_relative '../lib/books'
require 'nokogiri'
require 'httparty'

class Logic
  attr_reader :current_reader

  VALIDGENRES = ['Travel', 'Mystery', 'Historical Fiction', 'Sequential Art',
                 'Classics', 'Philosophy', 'Romance', 'Womens Fiction',
                 'Fiction', 'Childrens', 'Religion', 'Nonfiction', 'Music',
                 'Default', 'Science Fiction',
                 'Sports and Games', 'Add a comment', 'Fantasy',
                 'New Adult',
                 'Young Adult', 'Science', 'Poetry', 'Paranormal',
                 'Art', 'Psychology',
                 'Autobiography', 'Parenting', 'Adult Fiction', 'Humor',
                 'Horror',
                 'History', 'Food and Drink', 'Christian Fiction',
                 'Business',
                 'Biography', 'Thriller', 'Contemporary',
                 'Spirituality', 'Academic',
                 'Self Help', 'Historical', 'Christian', 'Suspense',
                 'Short Stories', 'Novels', 'Health', 'Politics',
                 'Cultural',
                 'Erotica',
                 'Crime'].freeze

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
    home_url = 'https://books.toscrape.com/catalogue/category/books'
    "#{home_url}/#{input_genre}_#{index}/index.html"
  end

  def search(url)
    unparsed_page = HTTParty.get(url)
    parse_page = Nokogiri::HTML(unparsed_page.body)
    books = parse_page.css('h3')
    arr = []
    books.each do |book|
      books = Books.New
      books.title = book.css('a.text').text
      books.price = book.css('p.price_color').text
      books.stock = book.css('p.instock availability').text
      arr.push(books)
    end
    arr
  end
end
