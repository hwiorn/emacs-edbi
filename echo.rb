#require 'elrpc'
require 'jimson'


class EchoHandler
  def ping(arg)
        "pong: #{arg}"
  end
end

server = Jimson::Server.new(EchoHandler.new)
#puts server.port
server.start
