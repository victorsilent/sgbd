require "./event.rb"
class Graph
  attr_reader :event

  def initialize
    @event = Event.new()
  end

  def rationalize_input(vector)
    vector = vector.split(" ")
    update_graph(vector[0],vector[1])
    draw_graph
  end

  def update_graph(method, transaction)
    method = method.downcase
    case method
    when 'tr_begin'
      @event.tr_begin(transaction)
    when 'read','write'
      @event.write_or_read(transaction)
    when 'tr_terminate'
      @event.tr_terminate(transaction)
    when 'tr_commit'
      @event.tr_commit(transaction)
    when 'tr_finish'
      @event.tr_finish(transaction)
    when 'tr_rollback'
      @event.tr_rollback(transaction)
    else
      puts "Invalid Command"
    end
  end

  def draw_graph
    puts "#-------------------#"
    @event.instance_variables.each do |x|
      puts "Transaction list at #{x}"
      puts @event.instance_variable_get(x)
    end
    puts "#-------------------#"
  end

end


graph = Graph.new()
user_entry = 1
while(user_entry != 0)
  puts "Type your transaction"
  user_entry = gets.chomp
  graph.rationalize_input(user_entry)
end
