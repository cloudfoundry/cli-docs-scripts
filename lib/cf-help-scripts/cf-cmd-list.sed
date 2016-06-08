# remove Index link in menu
s,<div id="home-link">.*</div>,,I

# add <table> at the start
s,<div id=\"start\"></div>,<div>,I

# move everything into a table for vertical alignment across sections
s,^   \(cf - .*\)$,<div><div colspan=\"2\">\1</div></div>,I

# usage uses full row (note usage omits initial [env..var] cli >6.16.1)
s,^   \(\[.*\)$,<div><div colspan=\"2\">\1</div></div>,I
s,^   \(cf \[.*\)$,<div><div colspan=\"2\">\1</div></div>,I

# version uses full row
s,^   [0-9].*$,<div><div colspan=\"2\">\0</div></div>,g

# create hyperlinks for commands
s,^   \([a-z][a-z-]*\) \(.*\)$,<div class="command"><div class="command-name"><a href=\"\1.html\">\1</a></div><div class="command-description">\2</div></div>,I

# environment variables and global options have description in 2nd column
s,^   \(.*  \)\(.*\)$,<div class="option"><div class="option-name">\1</div><div class="option-description">\2</div></div>,I

# environment variable https_proxy has only a single space up to its description
s,^   \(.*proxy.*:8080 \)\(.*\)$,<div class="option"><div class="option-name">\1</div><div class="option-description">\2</div></div>,I

# section headings use full rows
s,^\(\S.*\):\s*$,<div class="tr"><div class="section-heading"><h2 id=\"\1\">\1</h2></div></div>,I
#s,^\(\S.*\)(:\|\xef\xbc\x9a)\s*$,<div><div colspan=\"2\"><h2 id=\"\1\">\1</h2></div></div>,I

# close </table> at the end
$a</div>
$r footer.txt

