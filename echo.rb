#require 'elrpc'
require 'jimson'


class EchoHandler
  extend Jimson::Handler

  def ping(arg)
        "pong: #{arg}"
  end
end

server = Jimson::Server.new(EchoHandler.new, :port => 0)
server.start { |e|
  puts e
}
#t = Thread.new { puts server.start }
#puts server.port
sleep 1
puts server.port
t.join
