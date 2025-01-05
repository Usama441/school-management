require_relative 'student'
require_relative 'teacher'
require_relative 'school'

class ClassRooms < School
  
  attr_accessor :class_id,:grade,:student_list
  
  def initialize (id,grade)
    
    @class_id = id
    @grade    = grade 
    @student_in_class = []
    @coming_student_list = []
    @teacher = []

  end 

  def student_check(class_grade, new_student, batch)
    file_path = "classes/#{class_grade}/#{batch}.txt"
  
    # Ensure file exists
    unless File.exist?(file_path)
      FileUtils.mkdir_p(File.dirname(file_path))
      File.write(file_path, "")
    end
  
    # Clear @student_in_class and read existing students
    @student_in_class = []
    File.foreach(file_path) do |line|
      id, name = line.split(",").map(&:strip)
      @student_in_class << { id: id, name: name }
    end
  
    # Check for existing student
    student_exists = @student_in_class.any? do |existing_student|
      existing_student[:id] == new_student[:id] && existing_student[:name] == new_student[:name]
    end
  
    # Add new student if they don't exist
    unless student_exists
      File.open(file_path, 'a') do |class_file|
        class_file.puts "#{new_student[:id]},#{new_student[:name]}"
      end
      puts "New student added: #{new_student[:name]}"
    else
      puts "Student #{new_student[:name]} already exists in #{class_grade}."
    end
  end
  
  def add_student_in_class
    file_path = "students/students_data.txt"
    FileUtils.mkdir_p(File.dirname(file_path))
  
    # Read student data
    @coming_student_list = []
    File.foreach(file_path) do |line|
      id, name, age, dob, grade = line.split(",").map(&:strip)
      @coming_student_list << { id: id, name: name, age: age, dob: dob, grade: grade }
    end
  
    # Prompt for class grade
    print "Enter the class grade: "
    class_name = gets.chomp.strip
  
    # Check if class exists
    file_path = "classes/tottal_classes.txt"
    unless File.exist?(file_path)
      puts "The classes list file is missing."
      return
    end
  
    class_found = false
    File.foreach(file_path) do |line|
      if line.strip == class_name
        class_found = true
  
        # Process each student
        @coming_student_list.each do |student|
          if student[:grade] == class_name
            batch_id = student[:id]
            batch = batch_id[0,5]
            puts batch
            student_check(class_name, student, batch)
          end
        end
  
        puts "Students processed for the class: #{class_name}"
        break
      end
    end
  
    # Handle missing class
    unless class_found
      puts "There is no such class that you are looking for."
      puts "Please take permission from the head office to create a new class."
    end
  end
  
  
  def teacher_check(class_name,teacher_found,batch_id)
    
    temp_arr = []
    
    file_path = "classes/#{class_name}/#{batch_id}.txt"

    File.foreach(file_path) do |line|

       id,name = line.split(",").map(&:strip)
       temp_arr << {id: id,name:name}

    end

    teacher_exist  = temp_arr.any? do |teacher|
      
      teacher[:id] == teacher_found[:id] && teacher[:name] == teacher_found[:name]
    end

    if teacher_exist
      
      puts "#{teacher_found[:name]} is allready assigned in the class #{class_name}"

    else

        File.open(file_path, "w") do |file|
        file.puts "#{teacher_found[:id]},#{teacher_found[:name]}" 
        end
        puts "Teacher #{teacher_found[:name]} has been assigned to class #{class_name}"
    end
  end 

  def search_teacher (t_name,t_id,class_name,batch_id)
    
    teacher_found = nil
    file_path = "teachers/teachers_data.txt"
   
    File.foreach(file_path) do |line|

      id,name,age,dob,sub = line.split(",").map(&:strip)

      if id == t_id && name == t_name 
       
       teacher_found = {id: id, name: name, age: age, dob: dob,sub: sub}

       break
      end
    end

    if teacher_found
      
      teacher_check(class_name,teacher_found,batch_id)
  
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
    print 'Enter the batch '
    batch_id = gets.chomp
    temp_arr = []
    
    # storing the existing data od of class 
    file_path = "classes/#{class_name}/#{batch_id}.txt"
   
    File.foreach(file_path) do |line|
      
      id,name = line.split(",").map(&:strip)
      temp_arr << {id: id,name: name}

    end
    
    search_teacher(teacher_name,teacher_id,class_name,batch_id)

    File.open(file_path,'a') do |file|
      
      temp_arr.each do |student| 
      file.puts "#{student[:id]}, #{student[:name]}"

      end

    end 

  end

  
 
end

