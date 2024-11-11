require_relative 'student'
require_relative 'teacher'
require_relative 'school'
require_relative 'class_rooms'
require_relative 'subject'
class Grade < subject

  attr_accessor :teacher,:student,:class_room,:grade_value

  def initialize (teacher,student,subject)
      
     
     @teacher = teacher
     @student = student
     @subject = subject 

  end
  
  def calculate_grades(score)

    average_score = scores.sum / scores.size.to_f

    # Determine letter grade based on the average score
    case average_score
    when 90..100
      @grade_value = "A"
    when 80...90
      @grade_value = "B"
    when 70...80
      @grade_value = "C"
    when 60...70
      @grade_value = "D"
    else
      @grade_value = "F"
    end

  end

  def get_student
    

  end

end
 
 teacher =  Teacher.new("usama","dob",19,"teacher_id")
 student = Student.new("name", "date_of_birth", "age", "roll_number","grade")

 grade = Grade.new(teacher,student,subject)

 grade.get_student