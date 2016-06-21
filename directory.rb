
def input_students
#create an empty array for student data
students = [  {name: "Jack", cohort: :november, dob: "08/04/1991", hobbies: [:swimming, :skiing, :eating]},
              {name: "Jess", cohort: :november, dob: "29/05/1992", hobbies: [:skiing, :running, :reading]}
           ]

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.chomp

  #recursively loops while name has a value to allow multiple entry
  while !name.empty? do #as .chomp removes the last enter, using it twice breaks loop as it will be nil
    puts "Please enter a date of birth (dd/mm/yyyy) for #{name}"
    dob = gets.chomp
    puts "Enter hobbies for #{name}, hit return after each one. Two returns to finish"
    hobby = gets.chomp
    hobbies = []

        while !hobby.empty? do
          hobbies << hobby.to_sym
          hobby = gets.chomp
        end

    students << { name: name, cohort: :november, dob: dob, hobbies: hobbies } #adds hash with default data and name
    puts "Now we have #{students.count} students."  #states the updated number of student
    name = gets.chomp   #either start loop again or break it here
  end
  #returns array of students as an array of hashes
  students

end

def print_header   #method to print out header
  puts "The students of Villains Academy".center(100,'.')
  puts "-------------".center(100,'-')
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
        print "#{index}."
        print"#{student[:name]}".ljust(20,".")
        print"(#{student[:dob]})".center(20,".")
        print "(#{student[:cohort]} cohort)\n".rjust(20,'.')
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
