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

puts "The students of Villains Academy"
puts "-------------"
#lists all the name of the students
students.each { |name| puts name }
#next will show how many there are enrolled
print "Overall, we have #{students.count} great students"
