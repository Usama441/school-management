
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

    File.foreach('students_data.txt') do |line|
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

    print "Enter the grade of class : "
    class_name = gets.chomp
    file_path = "classes/#{class_name}/class.txt"
    directory = File.dirname(file_path)
    FileUtils.mkdir_p directory
    File.open(file_path,'w') do |line|
      #line.puts"~ WELLCOM TO #{class_name.upcase} CLASS ~"
    end
    
    File.open("tottal_classes.txt",'a') do |line|

      line.puts "#{class_name}"  
    end

  end

end

