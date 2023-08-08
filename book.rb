class Book
  include Comparable
  attr_reader :title, :author, :price

  def initialize(title, author, price)
    @title = title
    @author = author
    @price = price
  end

  def <=>(book)
    self.price <=> book.price
  end
end