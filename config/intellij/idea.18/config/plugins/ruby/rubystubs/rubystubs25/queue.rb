=begin
 This is a machine generated stub using stdlib-doc for <b>class Queue</b>
 Sources used:  Ruby 2.5.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

# The Queue class implements multi-producer, multi-consumer queues.
# It is especially useful in threaded programming when information
# must be exchanged safely between multiple threads. The Queue class
# implements all the required locking semantics.
# 
# The class implements FIFO type of queue. In a FIFO queue, the first
# tasks added are the first retrieved.
# 
# Example:
# 
#     queue = Queue.new
# 
#     producer = Thread.new do
#       5.times do |i|
#          sleep rand(i) # simulate expense
#          queue << i
#          puts "#{i} produced"
#       end
#     end
# 
#     consumer = Thread.new do
#       5.times do |i|
#          value = queue.pop
#          sleep rand(i/2) # simulate expense
#          puts "consumed #{value}"
#       end
#     end
class Queue
end
