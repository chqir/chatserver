# http_server.rb
require 'socket'
require '/Users/connormorrey/simplechatserver/members.rb'
require '/Users/connormorrey/simplechatserver/member.rb'
server = TCPServer.new 5678
puts "server running on port 5678"

members = Members.new

while true
  tcp_socket = server.accept
  Thread.new(tcp_socket) do |socket|
    member = members.register(socket)
    begin
      members.listening(member)
    rescue EOFError
      members.leave(member)
    end
  end
end
