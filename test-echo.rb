require 'jimson'


module JElrpc
  def self.start_process(cmd, host="http://localhost")
    # TODO run shell and read first line as port
    io = IO.popen(cmd)
    port = io.gets.to_i
    if port
      host = "#{host}:#{port}"
    end
    client = Jimson::Client.new(host)
    return client
  end
end

 # start a server process
# cl = Elrpc.start_process(["ruby","echo.rb"])
cl = JElrpc.start_process(["ruby","echo.rb"])
# cl = JElrpc.start_process("ruby echo.rb")
puts cl.ping("hhh")

# # synchronous calling
# puts cl.call_method("echo", "1 hello")

# # asynchronous calling
# cl.call_method_async("echo", "3 world") do |err, value|
#   puts value
# end

# puts "2 wait"
# sleep 0.2

# puts "4 ok"
#  # kill the server process
# cl.stop
