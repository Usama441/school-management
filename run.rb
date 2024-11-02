require_relative 'student'
require_relative 'teacher'
require_relative 'school'
require_relative 'class_rooms'

def clear_secreen
  
  system("clear") || system("cls")
  nil
end

def admin_block
  
  puts clear_secreen

  puts "          ~:: Wellcome to admin block ::~    "
  puts "                1. Add student "
  puts "                2. Add teacher "
  puts "                3. Add class room"
  puts "                4. Student count "
  puts "                5. Assigne teacher to class "
  puts "                6. Add students in classes "
  print"            Make your choice : "
  choice = gets.chomp
  
  school = School.new("Alllied","K.B COLLONY ")
  classroom  = ClassRooms.new("101-std","th")

  case choice.to_i

  when 1

      school.add_student
  when 2 

      school.add_teacher
    
  when 3
    
      school.add_class_rooms
    
    
  when 4 

      school.student_count
  
  when 5
      classroom.assign_teacher

  when 6  
      
    classroom.add_student_in_class
  
  else   

    puts "chose b/w (1 to 6) : "
    puts admin_block  
  
  end
      
end

def teacehr_block

  puts clear_secreen
  
  puts "          ~:: Wellcome to teacher block ::~  "
  puts "               1. Assigne grades "
  puts "               2. Take attendence "
  puts "               3. Search student "
  puts "               4. count students "

end

def student_block

  puts clear_secreen
  
  puts "         ~:: Wellcome to student portal ::~ "
  puts "              1. check details "
  puts "              2. get grades "
  puts "              3. get attendance details "
  puts "              4. attend_class"

end

def main

  puts "          ~:: WELLCOME TO SCHOOL MANAGMENT ::~          "
  puts "              1. Admin block   "
  puts "              2. Teacher block "
  puts "              3. Student block "
  print"              Enter your choice : "

  choice = gets.chomp.to_i

  case choice
     when 1
    
        puts admin_block
     
      when 2

        puts teacehr_block      
       
      when 3 
        
        puts student_block
  end

end


puts main