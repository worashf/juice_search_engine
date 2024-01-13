# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Testing user model' do

    before(:each) do
      User.destroy_all
    end

    subject do
      @user = User.create(name: 'Worash', ip_address: '192.168.20.20')
    end
    before { subject.save }
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end


    it 'User must have name'  do
      subject.name =  nil
      expect(subject).to_not be_valid
    end

    it 'User must have ip address' do
      subject.ip_address = nil
      expect(subject).to_not be_valid
    end

    describe '.find_by_ip_address' do

      it 'returns the correct user for a given IP address' do
        found_user = User.find_by_ip_address('192.168.20.20')
        expect(found_user).to eq(@user)
      end

      it 'returns nil when no user is found for the given IP address' do
        found_user = User.find_by_ip_address('192.168.20.21')
        expect(found_user).to be_nil
      end
    end

  end
end
