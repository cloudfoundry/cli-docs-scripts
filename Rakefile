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
    sh 'apt-get remove -y cf-cli'
    sh 'dpkg -i cf_cli.deb'
  end
end

desc 'Format `cf help` output to STDOUT'
task :format do |t, args|
  cli_major_version = Integer(`cf version`.strip.match(/cf version (\d+)\.\d+\.\d+\+\w/).captures.first)
  cli_help_text = `CF_COLOR=false cf help -a`

  require_relative 'lib/cli2docs'
  puts Cli2Docs.format cli_help_text, cli_major_version
end
