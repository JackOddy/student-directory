#names of all students in array
students = [
"Dr. Hannibal Lecter",
"Darth Vader",
"Nurse Ratched",
"Michael Corleone",
"Alex DeLarge",
"The Wicked Witch of the West",
"Terminator",
"Freddy Krueger",
"The Joker",
"Joffrey Baratheon",
"Norman Bates"]

def print_header   #method to print out header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_names roster   #lists all the name of the students
  roster.each { |name| puts name }
end

def print_footer (names)  #will show how many there are enrolled
  puts "Overall, we have #{names.count} great students"
end

print_header
print_names(students)
print_footer(students)
