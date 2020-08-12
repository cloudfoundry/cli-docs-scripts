require_relative '../lib/cli2docs'

describe Cli2Docs do
  describe '.format' do
    let(:cf_help) do
      <<-eos
NAME:
   cf - A command line tool to interact with Cloud Foundry

USAGE:
   [environment variables] cf [global options] command [arguments...] [command options]

GETTING STARTED:
   target                                 Set or view the targeted org or space

   api                                    Set or view target api url

ADD/REMOVE PLUGIN:
   plugins                                List all available plugin commands

INSTALLED PLUGIN COMMANDS:

ENVIRONMENT VARIABLES:
   CF_COLOR=false                     Do not colorize output
   CF_HOME=path/to/dir/               Override path to default config directory

GLOBAL OPTIONS:
   --version, -v                      Print the version
      eos
    end

    context 'when cli major version is 6' do
      it 'formats `cf help` output' do
        expect(Cli2Docs.format(cf_help, '6')).to eq(<<-eos.chomp)
---
title: Cloud Foundry CLI Reference Guide
---

## <a id='name'></a> Name
<p>cf - A command line tool to interact with Cloud Foundry</p>

## <a id='usage'></a> Usage
<p>[environment variables] cf [global options] command [arguments...] [command options]</p>

## <a id='getting-started'></a> Getting Started
<table>
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><a href='http://cli.cloudfoundry.org/en-US/v6/target.html' target='_blank'>target</a></td>
      <td>Set or view the targeted org or space</td>
    </tr>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><a href='http://cli.cloudfoundry.org/en-US/v6/api.html' target='_blank'>api</a></td>
      <td>Set or view target api url</td>
    </tr>
  </tbody>
</table>

## <a id='addremove-plugin'></a> Add/remove Plugin
<table>
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><a href='http://cli.cloudfoundry.org/en-US/v6/plugins.html' target='_blank'>plugins</a></td>
      <td>List all available plugin commands</td>
    </tr>
  </tbody>
</table>

## <a id='environment-variables'></a> Environment Variables
<table>
  <thead>
    <tr>
      <th>Variable</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>CF_COLOR=false</td>
      <td>Do not colorize output</td>
    </tr>
    <tr>
      <td>CF_HOME=path/to/dir/</td>
      <td>Override path to default config directory</td>
    </tr>
  </tbody>
</table>

## <a id='global-options'></a> Global Options
<table>
  <thead>
    <tr>
      <th>Option</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>--version, -v</td>
      <td>Print the version</td>
    </tr>
  </tbody>
</table>
eos
      end
    end

    context 'when cli major version is 7' do
      it 'formats `cf help` output' do
        expect(Cli2Docs.format(cf_help, '7')).to eq(<<-eos.chomp)
---
title: Cloud Foundry CLI Reference Guide
---

## <a id='name'></a> Name
<p>cf - A command line tool to interact with Cloud Foundry</p>

## <a id='usage'></a> Usage
<p>[environment variables] cf [global options] command [arguments...] [command options]</p>

## <a id='getting-started'></a> Getting Started
<table>
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><a href='http://cli.cloudfoundry.org/en-US/v7/target.html' target='_blank'>target</a></td>
      <td>Set or view the targeted org or space</td>
    </tr>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><a href='http://cli.cloudfoundry.org/en-US/v7/api.html' target='_blank'>api</a></td>
      <td>Set or view target api url</td>
    </tr>
  </tbody>
</table>

## <a id='addremove-plugin'></a> Add/remove Plugin
<table>
  <thead>
    <tr>
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td><a href='http://cli.cloudfoundry.org/en-US/v7/plugins.html' target='_blank'>plugins</a></td>
      <td>List all available plugin commands</td>
    </tr>
  </tbody>
</table>

## <a id='environment-variables'></a> Environment Variables
<table>
  <thead>
    <tr>
      <th>Variable</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>CF_COLOR=false</td>
      <td>Do not colorize output</td>
    </tr>
    <tr>
      <td>CF_HOME=path/to/dir/</td>
      <td>Override path to default config directory</td>
    </tr>
  </tbody>
</table>

## <a id='global-options'></a> Global Options
<table>
  <thead>
    <tr>
      <th>Option</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>--version, -v</td>
      <td>Print the version</td>
    </tr>
  </tbody>
</table>
eos
      end
    end
  end
end

