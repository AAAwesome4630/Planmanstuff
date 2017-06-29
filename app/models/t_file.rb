class TFile < ActiveRecord::Base
    belongs_to :classroom
    mount_uploader :file, FileUploader
    
end
