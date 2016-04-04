# section headings

# non-English section names; for the first two we predict and set the id
0,/^\(\S.*\):\s*$/ s/^\(\S.*\):\s*$/<p><h2 id=\"name\">\1<\/h2>/
0,/^\(\S.*\):\s*$/ s/^\(\S.*\):\s*$/<p><h2 id=\"usage\">\1<\/h2>/

# non-English section names
s,^\(\S.*\):\s*$,<p><h2 id=\"\1\">\1</h2>,g

# code formatting in usage and examples
s,^   cf .*$,<code>\0</code>,g
# cater for multi-line usage (cf push)
s,^   \[-.*$,<code>\0</code>,g

# options into data table
s,^   \(-.*\)  \(.*\)$,<dt><span class=\"option-name\">\1</span></dt><dd><p>\2</p></dd>,g

# create hyperlinks to other commands
s,'cf \([a-z]*\)','<a class=\"ref-to-other-cmd\" href=\"\1.html\">cf \1</a>',I

# styling of quoted constants and options ('none', '-f', etc.)
s,'\([a-z0-9/.#:-]*\)','<span class=\"term\">\1</span>',g

# styling of alias
s/^   [a-z]\{1,4\}$/<div class=\"alias-item\">\0<\/div>/I

# code styling to indented platform specific examples (see create-service)
s,^      cf \w.*,<code>\0</code>,g

# replace spaces with nbsp in options
s,\(-\w\) \(\w\),\1\&nbsp;\2,g
s,\(--.*\) \(\w\),\1\&nbsp;\2,g
#s,-no-,-no\&#8209;,g
#s,--,\&#8209;\&#8209;,g
#s,-\([a-z]\),\&#8209;\1,g

# add line breaks
# s/[^>]$/\0<br>/g

# add opening <dl> before first option entry
0,/^<dt>/s//\n<dl>\0/

# add closing </dl> at the end
$a</dl>
$r footer.txt

