# spec/models/article_spec.rb
require 'rails_helper'

RSpec.describe Article, type: :model do
  describe 'Testing article model' do
    let(:article) { Article.new(title: 'Test Title', body: 'Test Body') }

    it 'is valid with valid attributes' do
      expect(article).to be_valid
    end

    it 'is not valid without a title' do
      article.title = nil
      expect(article).to_not be_valid
    end

    it 'is not valid without a body' do
      article.body = nil
      expect(article).to_not be_valid
    end

    it 'is not valid with a title longer than 250 characters' do
      article.title = 'a' * 251
      expect(article).to_not be_valid
    end

    it 'is not valid with a body longer than 1000 characters' do
      article.body = 'a' * 1001
      expect(article).to_not be_valid
    end

    describe 'search_full_text' do
      it 'returns articles matching the search query' do
        Article.create(title: 'Ruby on Rails', body: 'A powerful web development framework')
        Article.create(title: 'React.js', body: 'A JavaScript library for building user interfaces')

        results = Article.search_full_text('Rails')
        expect(results.length).to eq(1)
        expect(results.first.title).to eq('Ruby on Rails')
      end

      it 'returns an empty array when no articles match the search query' do
        Article.create(title: 'Ruby on Rails', body: 'A powerful web development framework')

        results = Article.search_full_text('React.js')
        expect(results).to be_empty
      end
    end
  end
end
