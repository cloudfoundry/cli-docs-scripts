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

INSTALLED PLUGIN COMMANDS:

ENVIRONMENT VARIABLES:
   CF_COLOR=false                     Do not colorize output
   CF_HOME=path/to/dir/               Override path to default config directory

GLOBAL OPTIONS:
   --version, -v                      Print the version
      eos
    end

    it 'formats `cf help` output' do
      expect(Cli2Docs.format(cf_help)).to eq(<<-eos.chomp)
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
      <td>target</td>
      <td>Set or view the targeted org or space</td>
    </tr>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
    <tr>
      <td>api</td>
      <td>Set or view target api url</td>
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

