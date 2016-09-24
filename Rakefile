desc 'Set up cli2docs requirements'
task newb: :download

namespace :install do
  desc 'Install CF CLI on OS X'
  task :osx  do |t, args|
    sh 'brew tap cloudfoundry/tap'
    sh 'brew install cf-cli'
  end

  desc 'Install CF CLI on Linux'
  task :deb, [:version] do |t, args|
    version = args[:version]
    url = "https://cli.run.pivotal.io/stable?release=debian64&version=#{version}&source=github-rel"

    sh "wget -O cf_cli.deb '#{url}'"
    sh 'dpkg -i cf_cli.deb'
  end
end

desc 'Format `cf help` output to STDOUT'
task :format do
  require_relative 'lib/cli2docs'
  puts Cli2Docs.format `CF_COLOR=false cf help -a`
end
