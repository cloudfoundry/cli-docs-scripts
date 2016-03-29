# remove Index link in menu
s,<div id="home-link">.*</div>,,I

# add <table> at the start
s,<div id=\"start\"></div>,<table>,I

# move everything into a table for vertical alignment across sections
s,^   \(cf - .*\)$,<tr><td colspan=\"2\">\1</td></tr>,I

# usage uses full row (note usage omits initial [env..var] cli >6.16.1)
s,^   \(\[.*\)$,<tr><td colspan=\"2\">\1</td></tr>,I
s,^   \(cf \[.*\)$,<tr><td colspan=\"2\">\1</td></tr>,I

# version uses full row
s,^   [0-9].*$,<tr><td colspan=\"2\">\0</td></tr>,g

# create hyperlinks for commands
s,^   \([a-z][a-z-]*\) \(.*\)$,<tr><td><a href=\"\1.html\">\1</a></td><td>\2</td></tr>,I

# environment variables and global options have description in 2nd column
s,^   \(.*  \)\(.*\)$,<tr><td>\1</td><td>\2</td></tr>,I

# environment variable https_proxy has only a single space up to its description
s,^   \(.*proxy.*:8080 \)\(.*\)$,<tr><td>\1</td><td>\2</td></tr>,I

# section headings use full rows
s,^\(\S.*\):\s*$,<tr><td colspan=\"2\"><h2 id=\"\1\">\1</h2></td></tr>,I
#s,^\(\S.*\)(:\|\xef\xbc\x9a)\s*$,<tr><td colspan=\"2\"><h2 id=\"\1\">\1</h2></td></tr>,I

# close </table> at the end
$a</table>
$r footer.txt

