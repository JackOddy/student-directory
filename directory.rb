
def input_students
#create an empty array for student data
students = []

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp

  #recursively loops while name has a value to allow multiple entry
  while !name.empty? do
    #as .chomp removes the last enter, using it twice breaks loop as it will be nil
    students << { name: name, cohort: :november } #adds hash with default data and name
    puts "Now we have #{students.count} students."  #states the updated number of student
    name = gets.chomp   #either start loop again or break it here
  end
  #returns array of students as an array of hashes
  students

end

def print_header   #method to print out header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_names roster   #lists all the name of the students
  roster.each.with_index(1) { |student, index| puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_footer (names)  #will show how many there are enrolled
  puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print_names(students)
print_footer(students)
