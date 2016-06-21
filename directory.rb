

$months = {january:   1,
           february:  2,
           march:     3,
           april:     4,
           may:       5,
           june:      6,
           july:      7,
           august:    8,
           september: 9,
           october:  10,
           november: 11,
           december: 12}


$students = [  {name: "Jack", cohort: {month: :november, num: 11}, dob: "08/04/1991", hobbies: [:swimming, :skiing, :eating]},
               {name: "Jess", cohort: {month: :november, num: 11}, dob: "29/05/1992", hobbies: [:skiing, :running, :reading]},
               {name: "Julie", cohort: {month: :january, num: 1}, dob: "11/06/1997", hobbies: [:cooking, :reading, :dancing]},
               {name: "Oscar", cohort: {month: :june, num: 6}, dob: "06/07/1987", hobbies: [:running, :reading, :swimming]},
               {name: "Oliver", cohort: {month: :june, num: 6}, dob: "01/03/1982", hobbies: [:running, :dancing, :gym]}]

def input_students
#create an empty array for student data

  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  name = gets.sub("\n",'')

  #recursively loops while name has a value to allow multiple entry
  while !name.empty? do #as .chomp removes the last enter, using it twice breaks loop as it will be nil
    puts "Please enter a date of birth (dd/mm/yyyy) for #{name}."
    dob = gets.chomp.downcase
      until dob =~ /^[1-3][0-9]\/[0-9][0-9]\/[1-2][0-9][0-9][0-9]$/
        puts "Error. Invalid date of birth for #{name}. Enter correct date of birth."
        dob = gets.sub("\n",'')
      end

    puts "Please enter a cohort for #{name}."
    cohort = gets.sub("\n",'').downcase.to_sym
    cohort = :november if cohort.empty?
      until $months.include?(cohort)
        puts "Error. Please enter a valid month."
        cohort = gets.sub("\n",'').downcase.to_sym
      end


    puts "Enter hobbies for #{name}, hit return after each one. Two returns to finish."
    hobby = gets.sub("\n",'').downcase
    hobbies = []
        while !hobby.empty? do
          hobbies << hobby.to_sym
          hobby = gets.sub("\n",'').downcase
        end

    $students << { name: name, cohort: {month: cohort, num: $months[cohort]}, dob: dob, hobbies: hobbies } #adds hash with default data and name
    puts "Now we have #{$students.count} students.\n Enter another Name to add another student or hit return to finish"  #states the updated number of student
    name = gets.sub("\n",'').downcase   #either start loop again or break it here
  end
  #returns array of students as an array of hashes
  $students

end

def print_header   #method to print out header
  puts "The students of Villains Academy".center(100,'.')
  puts "-------------".center(100,'-')
end

def print_names roster   #lists all the name of the students

  if roster.empty?
    puts "Error: There are no students to display."
    return
  end

    puts "What is the first letter of the name of the student you are looking for?"
    puts "For full list hit return."
    first_letter = gets.chomp

    if !first_letter.empty?
#will find all students with a first name beginning with first_letter unless
      roster = roster.select {|student| student[:name] =~ /^#{Regexp.quote(first_letter)}/ }
    end
#now will remove student hashes with names longer than 12 char from local array

  roster.sort_by!{|student| student[:cohort][:num]}

#set a number for list
    index = 1

   roster.each.with_index(1) do |student, index|
        print "#{index}. "
        print"#{student[:name]}".ljust(20,".")
        print"(#{student[:dob]})".center(20,".")
        print "cohort:"
        print "#{student[:cohort][:month]}\n"
    end

end

def print_footer  #will show how many there are enrolled
    print "\nOverall, we have #{$students.count} great student"
    print 's' unless $students.count == 1
    puts #
end


def interactive_menu

  choices = ["1. View Students", "2. Add Students", "3. Exit Program"]
loop do
print_header
 puts "Menu".center(100,'~')
 puts "Please select an option".center(100,'-')
  choices.each { |x| puts x.center(100,'.')}
  input = gets.sub("\n", '')
    if input == "1"
      print_names($students)
      print_footer
    elsif input == "2"
      input_students
      print_footer
    elsif input == '3'
      return
    else
     puts "Error. Command not recognised."
     end

   end
end

interactive_menu
