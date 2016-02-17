desc 'Set up cli2docs requirements'
task newb: :download

desc 'Download CF CLI'
task :download, [:version] do
  version = args[:version]

  next if version.nil? && system('./cf > /dev/null')
  next if version && `./cf --version`.include?(version)

  os = case RbConfig::CONFIG['host_os']
         when /darwin/
           'macosx64'
         else
           'linux64'
       end

  url = "https://cli.run.pivotal.io/stable?release=#{os}-binary"
  url << "&version=#{version}" if version
  sh "curl -L '#{url}' | tar -zx"
end

desc 'Format `./cf help` output to STDOUT'
task :format do
  require_relative 'lib/cli2docs'
  puts Cli2Docs.format `./cf help`
end
