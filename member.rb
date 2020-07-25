class Member

  attr_reader :name, :socket

  def initialize(name, socket)
    @name = name
    @socket = socket
  end

  def welcome_message(members)
    socket.puts "welcome, #{name}. #{members.count} people here besides you."
  end
end
