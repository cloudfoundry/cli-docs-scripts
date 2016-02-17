desc 'Set up cli2docs requirements'
task newb: :download

desc 'Download CF CLI'
task :download, [:version] do |t, args|
  version = args[:version]

  next if version.nil? && File.exists?('cf')
  next if version && File.exists?('cf') && system('./cf --version | grep version')

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
