class Members
  include Enumerable

  def initialize
    @members = []
  end

  def register(socket)
    socket.print "enter your name: "
    name = socket.gets.chomp
    member = Member.new(name, socket)
    member.welcome_message(self)
    add(member)
    broadcast("|joined|", member)
    member
  end

  def leave (member)
    member.socket.close
    broadcast("|has left the chat|", member)
    remove(member)

  end

  def listening(member)
    loop do
      message = member.socket.readline
      broadcast(message, member)
    end
  end

  def each
    @members.each { |member| yield member }
  end

  def add(member)
    @members << member
  end

  def remove(member)
    @members.delete(member)
  end

  def broadcast (message, sender)
    recievers = @members - [sender]
    recievers.each do |reciever|
      reciever.socket.puts "##{sender.name}: #{message}"
    end
  end
end
