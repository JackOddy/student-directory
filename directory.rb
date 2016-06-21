
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

  while !roster
    return "Error: There are no students to display."
  end

    puts "What is the first letter of the name of the student you are looking for?"
    puts "For full list hit return twice."
    first_letter = gets.chomp

    if !first_letter.empty?
#will find all students with a first name beginning with first_letter unless
      roster = roster.select {|student| student[:name] =~ /^#{Regexp.quote(first_letter)}/ }
    end
#now will remove student hashes with names longer than 12 char from local array
  roster = roster.select {|student| student[:name].length <= 12}

#set a number for list
    index = 1

    while roster.any? do #will loop until roster is empty
#now return and remove the first hash in the local array and puts its values
      student = roster.shift
        puts "#{index}. #{student[:name]} (#{student[:cohort]} cohort)"
#add one to the index so the next time this block is run the number will have changed
        index += 1
    end

end

def print_footer (names)  #will show how many there are enrolled
    puts "Overall, we have #{names.count} great students"
end

students = input_students
print_header
print_names(students)
print_footer(students)
