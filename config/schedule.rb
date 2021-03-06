# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

job_type :runner,  "cd :path  && /bin/bash --login && rvm use 2.6.3 && bin/rails runner -e :environment ':task' :output"
every 1.day, at: '2am', :roles => [:app] do
  runner "Payment.send_payment_emails", :environment => 'development', :output => 'log/cron_update.log'
end