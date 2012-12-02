require 'beanstalk-client'


def runBeanstalkdDataReceiver
  puts "asdasd"
  beanstalk = Beanstalk::Pool.new(['127.0.0.1:12348'])
  puts 'connected'
  loop do
    puts 'getting'
    job = beanstalk.reserve
    puts 'received job'
  end
end 


a = Thread.new {runBeanstalkdDataReceiver()}
a.join
