class Bookstore
  attr_reader :books
  EMPTY_MESSAGE = 'Book store is empty'

  def initialize
    @books = []
  end

  def add_book(book)
    @books << book
    sort_books
  end

  def sort_books
    @books.sort!
  end

  def total_price
    books.sum(&:price)
  end

  def book_titles
    books.map(&:title)
  end

  def find_books_by_author(author)
    books.select{ |book| book.author.downcase == author.downcase }
  end

  def find_book_by_title(title)
    books.select{ |book| book.title.downcase == title.downcase }.first
  end

  def remove_books_by_author(author)
    return EMPTY_MESSAGE if empty?
    books.reject! { |book| book.author.downcase == author.downcase }
    sort_books
    'Books by this author has been successfully removed'
  end

  def remove_book_by_title(title)
    return EMPTY_MESSAGE if empty?
    books.reject! { |book| book.title.downcase == title.downcase }
    sort_books
    'Book successfully removed'
  end

  def cheapest_book
    @books[0]
  end

  def most_expensive_book
    @books[-1]
  end

  def empty?
    @books.count == 0
  end
end
