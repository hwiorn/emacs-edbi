#require 'elrpc'
require 'jimson'


class EchoHandler
  extend Jimson::Handler

  def ping(arg)
        "pong: #{arg}"
  end
end

server = Jimson::Server.new(EchoHandler.new, :port => 0)
t = Thread.new { puts server.start }
#puts server.port
sleep 1
puts server.port
t.join
