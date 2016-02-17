desc 'Set up cli2docs requirements'
task :newb do
  next if system('./cf > /dev/null')

  os = case RbConfig::CONFIG['host_os']
         when /darwin/
           'macosx64'
         else
           'linux64'
       end

  sh "curl -L 'https://cli.run.pivotal.io/stable?release=#{os}-binary' | tar -zx"
end

desc 'Format `cf help` output to STDOUT'
task format: :newb do
  require_relative 'lib/cli2docs'
  puts Cli2Docs.format `cf help`
end
