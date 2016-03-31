class Cli2Docs
  class << self
    HEADER_REGEX = /^([^\s].*?)(:|：)$/

    TITLE_HEADER = <<-EOS
---
title: Cloud Foundry CLI Reference Guide
---
    EOS

    TABLE_TEMPLATE= <<-EOS.chomp
<table>
  <thead>
    <tr>
      <th>%s</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
%s
  </tbody>
</table>
    EOS

    def format(cf_help)
      sections = []

      cf_help.each_line do |line|
        if line =~ HEADER_REGEX
          sections << [$1]
        else
          sections.last << line.strip
        end
      end

      sections = sections.reject do |section|
        body = section[1]
        body.empty?
      end

      out = []

      sections.each do |header, *body|
        id = header.downcase.gsub(' ', '-')
        text = header.split(' ').map(&:capitalize).join(' ')
        out << "## <a id='#{id}'></a> #{text}\n"

        body.pop if body.last.empty? # Remove empty line at the end of each section
        out.last << case header
                      when /NAME|USAGE|VERSION/
                        "<p>#{body.join("\n")}</p>"
                      when "GLOBAL OPTIONS"
                        self.tablify_body(body, separator: /\s{2,}/, column_name: 'Option')
                      when "ENVIRONMENT VARIABLES"
                        self.tablify_body(body, column_name: 'Variable')
                      else
                        self.tablify_body(body)
                    end
      end

      "#{TITLE_HEADER}\n#{out.join("\n\n")}"
    end

    def tablify_body(body, **options)
      separator = options.fetch(:separator, /\s+/)
      column_name = options.fetch(:column_name, 'Command')

      rows = body.inject('') do |rows, line|
        rows << if line.empty?
                  <<-EOS
    <tr class='separator'>
      <td></td>
      <td></td>
    </tr>
                  EOS
                else
                  command, description = line.split(separator, 2)
                  description ||= '&nbsp;'
                  <<-EOS
    <tr>
      <td><a href='http://cli.cloudfoundry.org/en-US/cf/#{command}.html' target='_blank'>#{command}</a></td>
      <td>#{description}</td>
    </tr>
                  EOS
                end
      end
      TABLE_TEMPLATE % [column_name, rows.chomp]
    end
  end
end
