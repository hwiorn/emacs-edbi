#require 'elrpc'
require 'jimson'


class EchoHandler
  extend Jimson::Handler

  def ping(arg)
        "pong: #{arg}"
  end
end

server = Jimson::Server.new(EchoHandler.new, :port => 0)
puts server.port
server.start
