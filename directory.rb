require "yaml"
#global months variable for multiple methods to use
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

$current_file = 'students.yml'
# students variable is global as multiple methods need to access it
# cohort value is a hash with num: key to allow them to be sorted by cohort when
# displayed. Hobbies is an array of symbols for looking up hobbies in common.
$students = []


def save_student(filename = '')
  set_current_file(filename)
  File.open($current_file,'w') do |f|
    f.write($students.to_yaml) # saves the whole array of hashes as a yaml file
  end
end

def load_students(filename = '')
  set_current_file(filename)
  $students = YAML.load(File.read($current_file))
  puts "Loaded #{$students.count} students from #{$current_file}.".center(100)#loads students array of hashes
end

def set_current_file(filename) #sets global variable to current file for ref.
    unless filename == ''
      until File.exist?(filename)
        puts "Error. File name not recognised. Please enter a valid filename."
        filename = STDIN.gets.chomp
      end
      $current_file = filename
    end
end

def try_load_students
  filename = ARGV.first
  return load_students if !filename
  if File.exist?(filename)
    load_students(filename)
  else
    puts "Error. #{filename} does not exist!"
  end
end

def input_students
  name = get_student_name
    while !name.empty? do
      cohort = get_student_cohort(name)
      dob = get_student_dob(name)
      hobbies = get_student_hobbies(name)
      $students << { name: name, cohort: {month: cohort, num: $months[cohort]}, dob: dob, hobbies: hobbies }
      # shovels the new hash compiled of previous user input into $students array
      puts "Now we have #{$students.count} students.".center(100,'.') # prints new total of students
      puts "Enter another Name to add another student or hit return to finish".center(100)
      name = STDIN.gets.chomp.downcase   #either start loop again or break it here
    end
end

def get_student_name
  puts "Please enter the names of the students"
  puts "To finish, just hit return twice"
  STDIN.gets.chomp
end

def get_student_dob(name)
  puts "Please enter a date of birth (dd/mm/yyyy) for #{name}."
  dob = STDIN.gets.chomp.downcase
    until dob =~ /^[0-3][0-9]\/[0-1][0-9]\/[1-2][0-9][0-9][0-9]$/
                #regex checks that numbers are valid and slashes are used.
      puts "Error. Invalid date of birth for #{name}. Enter correct date of birth."
      dob = STDIN.gets.chomp
    end
  dob
end

def get_student_cohort(name)
  puts "Please enter a cohort for #{name}."
  cohort = STDIN.gets.chomp.downcase.to_sym    # converts input to symbol
  cohort = :november if cohort.empty?           # hard coded default value for cohort
    until $months.include?(cohort)              # validates user input against $months
      puts "Error. Please enter a valid month." # if false will loop again
      cohort = STDIN.gets.chomp.downcase.to_sym
    end
  cohort
end

def get_student_hobbies(name)
  puts "Enter hobbies for #{name}, hit return after each one. Two returns to finish."
  hobby = STDIN.gets.chomp.downcase
  hobbies = [] #creates an empty array to contain hobbies
      while !hobby.empty? do
        hobbies << hobby.to_sym # hobbies inherits input as a symbol
        hobby = STDIN.gets.chomp.downcase #loops till hobby is nil for multiple entries
      end
  hobbies
end

def print_students (roster)   #lists all the name of the students

  if roster.empty?
    puts "Error: There are no students to display."
    return
  end

  roster = select_students(roster)

  roster.sort_by!{ |student| student[:cohort][:num]}.each.with_index(1) do |student, index|
     # iterates over roster to print out names formatted.
     # .with_index takes an argument to begin the index with and increments
     # each time. This will number each iteration accordingly.
        print "#{index}. "
        print"#{student[:name].capitalize}".ljust(20,".")
        print"(#{student[:dob]})".center(20,".")
        print "cohort:"
        print "#{student[:cohort][:month]}\n"
    end

end

def select_students(roster)
  puts "What is the first letter of the name of the student you are looking for?"
  puts "For full list hit return."
  first_letter = STDIN.gets.chomp.downcase

  if !first_letter.empty?
    #will select all students with a first name beginning with first_letter unless nil
    roster = roster.select {|student| student[:name].downcase =~ /^#{Regexp.quote(first_letter)}/ }
  end
  roster
end

def print_header   #method to print out header
  puts "The Students of Breakers Academy".center(100,'.')
  puts "=".center(100,'=') # pretty
end

def print_footer  #will show how many there are enrolled
    print "\nOverall, we have #{$students.count} great student"
    print 's' unless $students.count == 1 #add an s if plural
    puts # move onto the next line
end

def print_menu
  choices = ["1. View Students", "2. Add Students", "3. Save Database",
             "4. Load Student Database", "9. Exit Program"] #array of options
  puts "Menu".center(100,'~')
  puts "Please select an option".center(100,'-')
  choices.each do |option|
      puts ''.rjust(40,'.') + option.ljust(60,'.')
  end
end

def show_students
  print_header
  print_students($students)
  print_footer
end

def process(selection)
  case selection
  when "1"
    show_students
  when "2"
    input_students
  when "3"
    puts "What would you like to call the file? Hit return to use '#{$current_file}'"
    save_student(STDIN.gets.chomp)
  when "4"
    puts "Which file would you like to load? Hit return to load '#{$current_file}'"
    load_students(STDIN.gets.chomp)
  when "9"
    exit
  else
    puts "Error. Command not recognised"
  end
end

def interactive_menu
  loop do
    print_menu
    process(STDIN.gets.chomp)
  end
end

try_load_students
interactive_menu
