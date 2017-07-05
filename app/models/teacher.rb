class Teacher < ActiveRecord::Base
  belongs_to :school
  
  has_many :classroom, dependent: :destroy
  serialize :classrooms, Array
  
   def school_name
        school.try(:name)
   end
    
    def school_name=(name)
        self.school = School.find_by_name(name) if name.present?
    end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
