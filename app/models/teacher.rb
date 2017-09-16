class Teacher < ActiveRecord::Base
  mount_uploader :avatar, TeacherUploader
  
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
         
    validates_presence_of :first_name
  validates_presence_of :last_name
  validates_integrity_of  :avatar
  validates_processing_of :avatar
 
  private
  def avatar_size_validation
    errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
  end
end
