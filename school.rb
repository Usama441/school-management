
require_relative 'student'
require_relative 'teacher'
require 'fileutils'

class School
  attr_accessor  :school_name,:school_address
  
  def initialize(name,adress)
    @school_name = name
    @school_adress = adress
    @students = []
  

  end

  def add_student

    new_student = Student.new("name","DOB",22,"F2021065250","th")
    new_student.set_info
    new_student.store_info
  
  end

  def student_count 
    
    file_path = "students/students_data.txt"

    File.foreach(file_path) do |line|
      id, name, age,dob,grade  = line.split(",")
      @students << { id: id, name: name, age: age.to_i, dob:dob, grade:grade}
      
    end
    puts "Tottal student in our school : #{@students.size}"
  end

  def add_teacher

    new_teacher = Teacher.new("name","DOB",00,"id")
    new_teacher.set_info
    new_teacher.store_info

  end
  
  def add_class_rooms
    print "Enter the grade of class: "
    class_name = gets.chomp
  
    print "Enter the Batch ID: "
    batch_id = gets.chomp
    print "Summer or Fall batch "
    batch_type = gets.chomp

    directory = "classes/#{class_name}"
    file_path = "#{directory}/#{batch_type}#{batch_id}.txt"
  
    FileUtils.mkdir_p(directory) unless Dir.exist?(directory)
  
    File.open(file_path, 'w') do |file|
     
    end
  
    total_classes_file = 'classes/tottal_classes.txt'
  
   unless File.read(total_classes_file).include?("#{class_name}th")
     File.open(total_classes_file, 'a') do |file|
        file.puts "#{class_name}"
      end
    end
  end

end

