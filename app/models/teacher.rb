class Teacher < ActiveRecord::Base
  
  has_many :classroom, dependent: :destroy
  serialize :classrooms, Array
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
