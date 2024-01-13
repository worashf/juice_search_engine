# spec/models/search_analytic_spec.rb
require 'rails_helper'

RSpec.describe SearchAnalytic, type: :model do
  describe 'Testing search_analytic model' do
    let(:user) { User.create(name: 'Test User', ip_address: '192.168.0.1') }
    let(:article) { Article.create(title: 'Test Article', body: 'Test Body') }

    it 'is valid with valid attributes' do
      search_analytic = SearchAnalytic.new(user: user, prompt: 'Test Prompt')
      expect(search_analytic).to be_valid
    end

    it 'is not valid without a prompt' do
      search_analytic = SearchAnalytic.new(user: user)
      expect(search_analytic).to_not be_valid
    end

    it 'is not valid with a prompt less than 2 characters' do
      search_analytic = SearchAnalytic.new(user: user, prompt: 'A')
      expect(search_analytic).to_not be_valid
    end

    it 'is not valid with a prompt longer than 250 characters' do
      search_analytic = SearchAnalytic.new(user: user, prompt: 'a' * 251)
      expect(search_analytic).to_not be_valid
    end

    it 'belongs to a user' do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end

    it 'belongs to an article (optional)' do
      association = described_class.reflect_on_association(:article)
      expect(association.macro).to eq :belongs_to
      expect(association.options[:optional]).to eq true
    end

    describe '.find_search_by_user' do
      it 'returns search analytics with the given user and prompt' do
        SearchAnalytic.create(user: user, prompt: 'Test Prompt 1')
        SearchAnalytic.create(user: user, prompt: 'Test Prompt 2')

        results = SearchAnalytic.find_search_by_user(user, 'Test Prompt 1')
        expect(results.length).to eq(1)
        expect(results.first.prompt).to eq('Test Prompt 1')
      end
    end

    describe '.analytics_with_most_searched_prompt' do
      it 'returns search analytics with the most searched prompts in descending order' do
        SearchAnalytic.create(user: user, prompt: 'Test Prompt 1')
        SearchAnalytic.create(user: user, prompt: 'Test Prompt 2')
        SearchAnalytic.create(user: user, prompt: 'Test Prompt 2')

        results = SearchAnalytic.analytics_with_most_searched_prompt
        expect(results.first.prompt).to eq('Test Prompt 2')
        expect(results.first.prompt_count).to eq(2)
      end
    end

    describe '.analytics_with_most_searched_article' do
      it 'returns search analytics with the most searched articles in descending order' do
        SearchAnalytic.create(user: user, prompt: 'Test Prompt', article: article)
        SearchAnalytic.create(user: user, prompt: 'Test Prompt', article: article)
        SearchAnalytic.create(user: user, prompt: 'Test Prompt')

        results = SearchAnalytic.analytics_with_most_searched_article
        expect(results.first.article_id).to eq(article.id)
        expect(results.first.article_count).to eq(2)
      end
    end
  end
end
