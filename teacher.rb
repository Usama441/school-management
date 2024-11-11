
require_relative 'person'
require 'date'

class Teacher < Person

  attr_accessor :teacher_id,:subjects

  def initialize(name, date_of_birth, age,teacher_id)

    super(name, date_of_birth, age)
    @teacher_id = teacher_id
    @subjects  = ""
    # student.take_class() ## Dependency injection
    # single responsibility principle | with examples 
  end 

  def set_info

    print "Enter teacher name           : "
    @name = gets.chomp 
    print 'Enter date of birth          : '
    @date_of_birth = gets.chomp
    @date_of_birth = Date.parse(date_of_birth)
    calculate_age()
    print 'Enter teacher id             : '
    @teacher_id = gets.chomp
    assign_subjects(1)

  end
  
  def calculate_age
    today = Date.today
    @age = today.year - @date_of_birth.year
    if today.month < @date_of_birth.month || (today.month == @date_of_birth.month && today.day < @date_of_birth.day)
      @age -= 1
  
    end
  
  end
  
  def assign_subjects(no_of_subjects)

    (0..no_of_subjects.to_int-1).each do |i|
      
      print "Enter the subject name : "
      sub = gets.chomp
      @subjects<<sub
    
    end

  end

  def store_info

    file_path = "teachers/teachers_data.txt"
    directory = File.dirname(file_path)
    FileUtils.mkdir_p directory 
    File.open(file_path,"a") do |line|
      
      line.puts "#{@teacher_id},#{@name},#{@age},#{@date_of_birth},#{@subjects}"
   
    end
 
  end
  def assign_grade
    
    print "Enter your name : "
    teacher_name = gets.chomp
    print "Enter your ID : "
    teacher_id = gets.chomp
    
    teachers = []
    students = []
    student_found = []
    file_data = []

    File.foreach("teachers_data.txt") do |line|
      
      id,name,age,dob,subject = line.split(",").map(&:strip)
      teachers << {id: id,name: name,age: age,dob: dob,subject: subject}

    end 

    teacher_found = teachers.find do |teacher|

      teacher[:id] == teacher_id && teacher[:name] == teacher_name
    
    end

    if teacher_found
      
      system("clear") || system("cls")
    
      puts "You are only eligible to assigne grade for #{teacher_found[:subject]} "

      print "Enter the class name : "
      class_name = gets.chomp
    
      File.foreach("#{class_name}.txt") do |file|
      
        id, name = file.split(",").map(&:strip)
        students << {id: id , name: name}
    
      end
    
      print "Enter the student name : "
      student_name = gets.chomp
      print "Enter the student id : "
      student_id = gets.chomp

      student_found = students.find do |student|
      
        student[:id] == student_id && student[:name] == student_name

      end

      if student_found
      
        puts "Yes, student #{student_found[:name]} with ID #{student_found[:id]} is found."

        print "Enter the score : "
        score = gets.chomp

        File.open("#{student_id}_grades.txt",'a').close

        if File.zero?("#{student_id}_grades.txt")
          
          File.open("#{student_id}_grades.txt",'a+') do |line|
          
            line.puts "#{teacher_found[:subject]}:#{score}"
      
          end

        else

          File.foreach("#{student_id}_grades.txt") do |line|
            
            sub_name,sub_score = line.split(":").map(&:strip)
            file_data << {name: sub_name,score: sub_score}

          end

          subject_updated = false
          file_data.each do |data|
            if data[:name] == teacher_found[:subject]
              data[:score] = score  
              subject_updated = true
              break
            end
          end

    unless subject_updated
      file_data << { name: teacher_found[:subject], score: score }
    end

    File.open("#{student_id}_grades.txt", 'w') do |file|
      file_data.each do |data|
        file.puts "#{data[:name]}:#{data[:score]}"
      
      end
      end
      
        end    
      else 

        puts "student is not found"
      end
    
    else
      
      puts "Teacher is not found : "
      puts "Enter the correct id and name to finde it :"

    end

  end
  
  def count_student_in_his_class
   
   
   print 'Enter you class name : '
  
   class_name = gets.chomp

   #authentication feature will be add soon 
  
   ids = []  # Array to store ids
   file_path = "classes/#{class_name}/class.txt"
   File.foreach(file_path) do |line|
     id, name = line.split(",").map(&:strip)
     ids << id  # Store only the id in the array
   end
   
   student_count = ids.count { |s| s.start_with?("S")} + ids.count { |s| s.start_with?("F")}
  
   puts "Tottal Students in class : #{student_count}"

  end
  
  def take_attendance
    
  end

end



teacher = Teacher.new("name", "date_of_birth", "age","teacher_id")

teacher.count_student_in_his_class