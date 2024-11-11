require_relative 'person'
require 'date'

class Student < Person
  attr_accessor :roll_number,:grade
  
  
  def initialize(name, date_of_birth, age, roll_number,grade)
    
    super(name, date_of_birth, age)
    @roll_number = roll_number
    @grade = grade
  end
  
  def set_info 

    print "Enter student name           : "
    @name = gets.chomp 
    print 'Enter date of birth          : '
    @date_of_birth = gets.chomp
    @date_of_birth = Date.parse(date_of_birth)
    calculate_age()
    print 'Enter your roll number       : '
    @roll_number = gets.chomp
    print 'Enter the class eg(10th,9th) : '
    @grade = gets.chomp


  end

  def calculate_age
    today = Date.today
    @age = today.year - @date_of_birth.year
    
    if today.month < @date_of_birth.month || (today.month == @date_of_birth.month && today.day < @date_of_birth.day)
      @age -= 1
    end
  end

  def store_info
    
    file_path = "students/students_data.txt"
    directory = File.dirname(file_path)
    FileUtils.mkdir_p directory 
    
    File.open(file_path,"a") do |line|

       line.puts "#{@roll_number},#{@name},#{@age},#{@date_of_birth},#{@grade}"
    
      end
  end

  def get_grades
    
  end

  def attend_class
    
  end
end

#s = Student.new("name","DOB",22,"F2021065250",10th)
#s1 = Student.new("name","DOB",22,"F2021065250")
#s.set_info 
#s.store_info

#s1.set_info 
#s1.store_info
