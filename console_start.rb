require 'pry'
Dir["#{File.dirname(__FILE__)}/functions/**/*.rb"].each {|file| require file }

def is_stop_command?(function_name)
  if %w(stop exit quit).include?(function_name)
    puts "STOPPING"
    true
  else
    false
  end
end

loop do
  puts "What function do you want to invoke?"

  input_string = gets

  input_parts = input_string.split(' ')

  next if input_parts.count <= 0

  function_name, *arguments = input_parts

  break if is_stop_command?(function_name)

  returned_data = send(function_name, *arguments)

  puts returned_data

rescue NoMethodError => e
  puts "ERROR : ##{function_name}."
  puts "Method not found"
  next
rescue ArgumentError => e
  puts "ERROR : ##{function_name}."
  puts e.message
  next
end