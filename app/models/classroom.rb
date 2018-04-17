
class Classroom < ActiveRecord::Base
  
    has_secure_password :validations => false
    belongs_to :teacher
    
    has_many :sc_relationships, dependent: :destroy 
    serialize :students, Array
    has_many :quizzes, dependent: :destroy
    has_many :tests, dependent: :destroy
    has_many :assignments, dependent: :destroy
    has_many :announcements, dependent: :destroy
    has_many :t_files, dependent: :destroy
    
    def self.search(search)
      where("LOWER(name) LIKE ?", "%#{search.downcase}%") 
    end
    
end
