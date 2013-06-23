require "pry"

class Student

  attr_accessor :name, :email, :phone
  
  def initialize(student_h)
    @name = student_h[:name]
    @email = student_h[:email]
    @phone = student_h[:phone]
  end
 
end