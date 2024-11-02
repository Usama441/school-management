require_relative 'student'
require_relative 'teacher'
require_relative 'school'
require_relative 'class_rooms'

class Grade 

  attr_accessor :teacher,:student,:class_room,:grade_value

  def initialize (teacher)
      
     
     @teacher = teacher
     
  end

  def get_student
    
    @teacher.inspect
    puts "#{@teacher}"

  end
  def set_grades

  end
end
teacher =  Teacher.new("name","dob","age","teacher_id")   
 grade = Grade.new (teacher)

 grade.get_student