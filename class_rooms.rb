require_relative 'student'
require_relative 'teacher'
require_relative 'school'

class ClassRooms < School
  
  attr_accessor :class_id,:grade,:student_list
  
  def initialize (id,grade)
    
    @class_id = id
    @grade    = grade 
    @existing_student_list = []
    @coming_student_list = []
    @teacher = []

  end
  
  def student_check(class_grade, new_student)
   
    File.foreach("#{class_grade}.txt") do |line|
      id, name, age, dob, grade = line.split(",").map(&:strip)
      @existing_student_list << { id: id, name: name, age: age, dob: dob, grade: grade }
    end

    student_exists = @existing_student_list.any? do |existing_student|
      existing_student[:id] == new_student[:id] && existing_student[:name] == new_student[:name]
    end

    if student_exists
      puts "Student #{new_student[:name]} already exists in #{class_grade}."
    else
      File.open("#{class_grade}.txt", 'a') do |class_file|
        class_file.puts "#{new_student[:id]}, #{new_student[:name]}"
      end
      puts "New student added: #{new_student[:name]}"
    end
  end


  def add_student_in_class
    
    File.foreach("students_data.txt") do |line|
      id, name, age, dob, grade = line.split(",").map(&:strip)
      @coming_student_list << { id: id, name: name, age: age, dob: dob, grade: grade }
    end

    print "Enter the class grade: "
    class_name = gets.chomp.strip  
    class_found = false

    
    File.foreach("tottal_classes.txt") do |line|
      if line.strip == class_name
        class_found = true

        @coming_student_list.each do |student|
          if student[:grade] == class_name
               student_check(class_name, student)  
          end
        end

        puts "Students processed for the class: #{class_name}"
        break
      end
    end

  
    unless class_found
      puts "There is no such class that you are looking for."
      puts "Please take permission from the head office to create a new class."
    end
  end
  
  def teacher_check(class_name,teacher_found)
    
    temp_arr = []

    File.foreach("#{class_name}.txt") do |line|

       id,name = line.split(",").map(&:strip)
       temp_arr << {id: id,name:name}

    end

    teacher_exist  = temp_arr.any? do |teacher|
      
      teacher[:id] == teacher_found[:id] && teacher[:name] == teacher_found[:name]
    end

    if teacher_exist
      
      puts "#{teacher_found[:name]} is allready assigned in the class #{class_name}"

    else

        File.open("#{class_name}.txt", "w") do |file|
        file.puts "#{teacher_found[:id]},#{teacher_found[:name]}" 
        end
        puts "Teacher #{teacher_found[:name]} has been assigned to class #{class_name}"
    end
  end 

  def search_teacher (t_name,t_id,class_name)
    
    teacher_found = nil
    File.foreach("teachers_data.txt") do |line|

      id,name,age,dob,sub = line.split(",").map(&:strip)

      if id == t_id && name == t_name 
       
       teacher_found = {id: id, name: name, age: age, dob: dob,sub: sub}

       break
      end
    end

    if teacher_found
      
      teacher_check(class_name,teacher_found)
  
    else
   
    puts "Sorry, teacher not found or does not exist in the file."
    puts "Try again by entering the correct id and name."
  
    end

  end

  def assign_teacher

    print 'Enter class name : '
    class_name = gets.chomp
    print 'Enter teacher name : '
    teacher_name = gets.chomp 
    print 'Enter teacher id : '
    teacher_id = gets.chomp
    
    temp_arr = []

    File.foreach("#{class_name}.txt") do |line|
      id,name = line.split(",").map(&:strip)

      temp_arr << {id: id,name: name}

    end
    
    search_teacher(teacher_name,teacher_id,class_name)

    File.open("#{class_name}.txt",'a') do |file|
      
      temp_arr.each do |student| 
      file.puts "#{student[:id]}, #{student[:name]}"

      end

    end 

  end

  
 
end


