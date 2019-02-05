=begin
 This is a machine generated stub using stdlib-doc for <b>class ConditionVariable</b>
 Sources used:  Ruby 2.5.0-preview1
 Created by IntelliJ Ruby Stubs Generator.
=end

# ConditionVariable objects augment class Mutex. Using condition variables,
# it is possible to suspend while in the middle of a critical section until a
# resource becomes available.
# 
# Example:
# 
#   mutex = Mutex.new
#   resource = ConditionVariable.new
# 
#   a = Thread.new {
#      mutex.synchronize {
#        # Thread 'a' now needs the resource
#        resource.wait(mutex)
#        # 'a' can now have the resource
#      }
#   }
# 
#   b = Thread.new {
#      mutex.synchronize {
#        # Thread 'b' has finished using the resource
#        resource.signal
#      }
#   }
class ConditionVariable
end
