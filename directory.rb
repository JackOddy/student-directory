#names of all students in array
students = [
{ name: "Dr. Hannibal Lecter", cohort: :november},
{ name: "Darth Vader", cohort: :november},
{ name: "Nurse Ratched", cohort: :november},
{ name: "Michael Corleone", cohort: :november},
{ name: "Alex DeLarge", cohort: :november},
{ name: "The Wicked Witch of the West", cohort: :november},
{ name: "Terminator", cohort: :november},
{ name: "Freddy Krueger", cohort: :november},
{ name: "The Joker", cohort: :november},
{ name: "Joffrey Baratheon", cohort: :november},
{ name: "Norman Bates", cohort: :november}
]

def print_header   #method to print out header
  puts "The students of Villains Academy"
  puts "-------------"
end

def print_names roster   #lists all the name of the students
  roster.each { |student| puts "#{student[:name]} (#{student[:cohort]} cohort)" }
end

def print_footer (names)  #will show how many there are enrolled
  puts "Overall, we have #{names.count} great students"
end

print_header
print_names(students)
print_footer(students)
