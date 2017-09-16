class School < ActiveRecord::Base
  
    
    def self.search(search)
      where("LOWER(name) LIKE ?", "%#{search.downcase}%") 
    end
    
    has_secure_password
    has_many :administrators, dependent: :destroy
    has_many :s_srelationships, dependent: :destroy
    
    serialize :administrators, Array
    serialize :teachers, Array
    serialize :students, Array
end
