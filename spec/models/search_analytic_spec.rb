# spec/models/search_analytic_spec.rb
require 'rails_helper'

RSpec.describe SearchAnalytic, type: :model do



  describe 'Testing search_analytic model' do


    let!(:user) { User.create(name: 'Test User', ip_address: '192.168.0.1') }
    let!(:article) { Article.create(title: 'Test Article', body: 'Test Body') }


    it 'is valid with valid name and ip addess' do
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
      expect(association.options).to include(optional: true)
    end




  end
end
