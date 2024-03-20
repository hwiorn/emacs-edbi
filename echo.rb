#require 'elrpc'
require 'jimson'


class EchoHandler
  extend Jimson::Handler

  def ping(arg)
        "pong: #{arg}"
  end
end

server = Jimson::Server.new(EchoHandler.new,
                           :host => '127.0.0.1',
                           :port => TCPServer.open('localhost', 0){|s| s.addr[1] })
puts server.port
server.start
