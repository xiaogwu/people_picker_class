require "./student"
require 'json'

=begin
# TODO:
[x] 1. Use student class
[x] 1. Use JSON parser to read in classlist.json
[x] 1. Work with array of student hashes
[x] 1. Write array of student hashes to file
=end

# student_h = { 
#               :name => "Xiao G. Wu",
#               :email => "xiaogwu@gmail.com",
#               :phone => "415.891-9426"
#             }

# student1 = Student.new(student_h)
# p student1

students_a_h = JSON.parse(File.open("./classlist.json", "r").read, :symbolize_names => true)
# p students_a_h

students_a = []
students_a_h.each do |student|
  students_a << Student.new(student)
end

students_a.each do |student|
  p student.name
end

File.open("./classlist_out.json", "w").write(JSON.pretty_generate(students_a))
