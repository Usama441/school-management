
require_relative 'student'
require_relative 'teacher'
require_relative 'school'
require_relative 'class_rooms'
require_relative 'subject'

class Subject 

   attr_accessor :subjectName,:subjectCode,:teacher

    def initialize (name,code,teacher)
           
        @subject = name
        @subject_code = code
        @teacher = teacher

    end

    def assignGrade()
    
    
    end	
    
    def updateGrade()
    
    
    end



end