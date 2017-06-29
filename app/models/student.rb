class Student < ActiveRecord::Base
  
  has_many :sc_relationships, dependent: :destroy
  has_many :individual_assignments, dependent: :destroy
  has_many :individual_tests, dependent: :destroy
  serialize :classrooms, Array
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
