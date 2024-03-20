require 'elrpc'


def start_process(cmd, host="http://localhost")

end

 # start a server process
#cl = Elrpc.start_process(["ruby","echo.rb"])

 # synchronous calling
puts cl.call_method("echo", "1 hello")

 # asynchronous calling
cl.call_method_async("echo", "3 world") do |err, value|
  puts value
end

puts "2 wait"
sleep 0.2

puts "4 ok"
 # kill the server process
cl.stop
