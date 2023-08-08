require 'rspec'

RSpec.describe Bookstore do
  let(:book1) { Book.new('dragon chronicles', 'Gian', 30) }
  let(:book2) { Book.new('Matrix Trilogy', 'Mike', 50) }
  let(:book3) { Book.new('Bourne Identity', 'Mike', 20) }

  let(:total_price) { book1.price + book2.price }

  describe '#add_book' do
    it 'adding book to book store' do
      expect{subject.add_book(book1)}.to change {
        subject.books.count
      }.by(1)
    end

    it 'sort is applied whenever any book is added' do
      expect(subject.books).to receive(:sort!)

      subject.add_book(book2)
    end
  end

  describe '#total_price' do
    it 'returns 0 if book store empty' do
      expect(subject.total_price).to be(0)
    end

    it 'returns total price of all the books in bookstore' do
      subject.add_book(book1)
      subject.add_book(book2)

      expect(subject.total_price).to be(total_price)
    end
  end

  describe '#book_titles' do
    it 'returns empty array if book store empty' do
      expect(subject.book_titles).to eq([])
    end

    it 'returns list of all titles' do
      subject.add_book(book1)

      expect(subject.book_titles).to eq([book1.title])
    end
  end

  describe '#find_books_by_author' do
    before do
      subject.add_book(book1)
      subject.add_book(book2)
      subject.add_book(book3)
    end

    it 'returns empty array if no book is present of the given author' do
      expect(subject.find_books_by_author('abc')).to eq([])
    end

    it 'returns all books by author' do  
      expect(subject.find_books_by_author('Mike')).to match_array([book2, book3])
    end

    it 'returns all books by author regardless of case sentivity' do  
      expect(subject.find_books_by_author('miKe')).to match_array([book2, book3])
    end
  end

  describe '#find_book_by_title' do
    before do
      subject.add_book(book1)
      subject.add_book(book2)
    end

    it 'returns nil if no book is present with given title' do
      expect(subject.find_book_by_title('no_title')).to eq(nil)
    end

    it 'returns book who has the same title as given' do
      expect(subject.find_book_by_title('Matrix Trilogy')).to eq(book2)
    end

    it 'returns book who has the same title as given regardless of case sentivity' do
      expect(subject.find_book_by_title('matrix Trilogy')).to eq(book2)
    end
  end

  describe '#remove_books_by_author' do
    it 'returns empty error message if no book is present with given author' do
      expect(subject.remove_books_by_author('no_author')).to eq(subject.class::EMPTY_MESSAGE)
    end

    context 'remove books by given author' do
      before do 
        subject.add_book(book1)
        subject.add_book(book2)
      end

      it 'remove books by given author' do
        subject.remove_books_by_author('Mike')
  
        expect(subject.books).to eq([book1])
      end

      it 'remove books even if author name matches regardlesss of case senstivity' do
        subject.remove_books_by_author('mike')
  
        expect(subject.books).to eq([book1])
      end
    end
    
  end

  describe '#remove_book_by_title' do
    it 'returns empty error message if no book is present with given title' do
      expect(subject.remove_book_by_title('no_title')).to eq(subject.class::EMPTY_MESSAGE)
    end

    context 'remove book by title' do
      before do
        subject.add_book(book1)
        subject.add_book(book2)
      end

      it 'remove book whose title matches' do  
        subject.remove_book_by_title('dragon chronicles')
  
        expect(subject.books).to eq([book2])
      end

      it 'remove book whose title matches regardless of case senstivity' do  
        subject.remove_book_by_title('Dragon Chronicles')
  
        expect(subject.books).to eq([book2])
      end
    end
  end

  describe '#empty?' do
    it 'returns true if there is no book in bookstore' do
      expect(subject.empty?).to be(true)
    end
  
    it 'returns false if there is any book in bookstore' do
      subject.add_book(book1)

      expect(subject.empty?).to be(false)
    end
  end

  describe '#cheapest_book' do
    it 'returns nil if book store is empty' do
      expect(subject.cheapest_book).to eq(nil)
    end

    it 'returns cheapest book from all the books in book store' do
      subject.add_book(book1)
      subject.add_book(book2)
      subject.add_book(book3)

      expect(subject.cheapest_book).to eq(book3)
    end
  end

  describe '#most_expensive_book' do
    it 'returns nil if there is no book in bookstore' do
      expect(subject.most_expensive_book).to be(nil)
    end
  
    it 'return book with highest price in bookstore' do
      subject.add_book(book1)
      subject.add_book(book2)
      subject.add_book(book3)

      expect(subject.most_expensive_book).to be(book2)
    end
  end

end
