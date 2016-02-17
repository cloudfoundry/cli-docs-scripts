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
  <tr>
    <th>Command</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>target</td>
    <td>Set or view the targeted org or space</td>
  </tr>
  <tr>
    <td></td>
    <td></td>
  </tr>
  <tr>
    <td>api</td>
    <td>Set or view target api url</td>
  </tr>
</table>

## <a id='global-options'></a> Global Options
<table>
  <tr>
    <th>Command</th>
    <th>Description</th>
  </tr>
  <tr>
    <td>--version, -v</td>
    <td>Print the version</td>
  </tr>
</table>
      eos
    end

  end

end

