#!/usr/bin/env ruby

require '/Users/xiaogwu/Code/wk01d06/people_picker_class/student.rb'
require 'json'
require 'pry'


# TODO
# [x] 1. Read in students.json file if it exists otherwise assume empty array
# [x] 1.2 Instantiate student class objects for each student
# [x] 2. Get random name(s) from students array based on -n flag
# [x] 3. Create group of n people based on -g flag
# [x] 4. Create n groups based on -G flag


# Read in students.json file and put in students array if json file exists, otherwise assume empty array
if FileTest.exist?("/Users/xiaogwu/Code/wk01d06/people_picker_class/students.json")
  students = JSON.parse(File.open("/Users/xiaogwu/Code/wk01d06/people_picker_class/students.json", "r").read, :symbolize_names => true)
else
  students = []
end

students_roster ||= []
# Instantiate student class object for each student
students.each do |student|
  students_roster << Student.new(student)
end

# Method to shuffle array in place
def randomize(students)
  students.shuffle!
end

# Method to print groups
def output_groups(students, size_of_group)
  group_id = 1
  until students.size == 0 do
    puts "Group " + group_id.to_s
    puts "================="
    students.shift(size_of_group).each { |student| puts student.name }
    puts
    group_id += 1
  end
end
# Method to print usage
def print_usage
  puts "Usage: " + File.basename($0)
  puts "       " + File.basename($0) + " -n N (N number of random people)"
  puts "       " + File.basename($0) + " -g N (Groups of N random people)"
  puts "       " + File.basename($0) + " -G N (N Groups of random people)"
end
# Method to print error message
def print_error
  puts $0 + ": illegal option " + ARGV[0]
  print_usage
end
# Method to print missing second argument
def print_missing_sec_arg
  puts ARGV[0] + " requires second argument"
  print_usage
end

# >>> START <<<
# Flags logic
# Default bahavior is to print one random person
if ARGV.size == 0 then
  randomize(students_roster)
  # Print first person from randomized array
  puts "Student selected: " + students_roster.first.name
# Only one arg provided
elsif ARGV.size == 1 then
  case ARGV[0]
  when '-h' then
    print_usage
  when '-?' then
    print_usage
  when '-n' then
    print_missing_sec_arg
  when '-g' then
    print_missing_sec_arg
  when '-G' then
    print_missing_sec_arg
  else
    print_error
  end
# Proper Flags specified
elsif ARGV.size == 2 then
  case ARGV[0]
  when '-n' then
    # Random number flag selected
    randomize(students_roster)
    puts "Number of people specified exceed class size" if (ARGV[1].to_i - 1) > students_roster.size
    puts ARGV[1] + " Random people from class" unless (ARGV[1].to_i - 1) > students_roster.size
    puts "=============================" unless (ARGV[1].to_i - 1) > students_roster.size
    puts names[0..ARGV[1].to_i - 1] unless (ARGV[1].to_i - 1) > students_roster.size
  when '-g' then
    # Group of n flag selected
    randomize(students_roster)
    size_of_group = ARGV[1].to_i
    output_groups(students_roster, size_of_group)
  when '-G' then
    # n Groups flag selected
    randomize(students_roster)
    size_of_group = (students_roster.size / ARGV[1].to_i).ceil + 1
    output_groups(students_roster, size_of_group)
  else
    # Flag error provide Usage
    print_error
  end
end
