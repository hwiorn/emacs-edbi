#!/usr/bin/env ruby
require 'elrpc'

# (require 'edbi)
# (setq conn1 (edbi:start))
# (edbi:connect conn1 '("dbi:SQLite3:/Users/gglee/test.sqlite" "" ""))

# (require 'epc)

# (let (epc)
#   ;; start a server process (using bundle exec)
#   (setq epc (epc:start-epc "ruby" '("/Users/gglee/.config/doom/lisp/emacs-edbi/edbi-bridge.rb")))
#   (epc:call-sync epc 'connect '("dbi:SQLite3:/Users/gglee/test.sqlite" "" ""))
#   ;; (deferred:$
#   ;;  (epc:call-deferred epc 'connect '("dbi:SQLite3:/Users/gglee/test.sqlite" "" ""))
#   ;;  (deferred:nextc it
#   ;;                  (lambda (x) (message "Return : %S" x))))

#   ;;(message "%S" (epc:call-sync epc 'echo '(world)))
#   ;;(epc:stop-epc epc)
#   )


 # start a server process
cl = Elrpc.start_process(["bundle", "exec", "ruby", "edbi-bridge.rb"])

 # synchronous calling
#puts cl.call_method("connect", "dbi:SQLite3:/Users/gglee/test.sqlite", "", "")
puts cl.call_method("connect", "dbi:SQLite3:/Users/gglee/test.sqlite", "", "")

#  # asynchronous calling
# cl.call_method_async("echo", "3 world") do |err, value|
#   puts value
# end

# puts "2 wait"
# sleep 0.2

gets
# puts "4 ok"
#  # kill the server process
cl.stop
