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
      <th>Command</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
%s
  </tbody>
</table>
    EOS
    
    def format cf_help
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
                        self.tablify_body(body, /\s{2,}/)
                      else
                        self.tablify_body(body)
                    end
      end

      "#{TITLE_HEADER}\n#{out.join("\n\n")}"
    end

    def tablify_body(body, separator=/\s+/)
      rows = body.inject('') do |rows, line|
        command, description = line.split(separator, 2)
        rows << <<-EOS
    <tr>
      <td>#{command}</td>
      <td>#{description}</td>
    </tr>
        EOS
      end
      TABLE_TEMPLATE % rows.chomp
    end
  end
end
