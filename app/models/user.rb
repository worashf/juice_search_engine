class User < ApplicationRecord
    has_many :search_analytics, class_name: 'SearchAnalytic'
    validates :name, :ip_address, presence: true

    # find currect user
    def self.find_by_ip_address(ip_address)
        find_by(ip_address: ip_address)
      end
end
