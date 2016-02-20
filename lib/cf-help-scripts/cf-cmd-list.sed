# remove Home link in menu
s, <li.*Up</a></li>,,I

# add <table> at the start
s,<div id=\"start\"></div>,<table>,I

# move everything into a table for vertical alignment across sections
s,^   \(cf - .*\)$,<tr><td colspan=\"2\">\1</td></tr>,I

# create hyperlinks for commands
s,^   \([a-z-]*\) \(.*\)$,<tr><td><a href=\"\1.html\">\1</a></td><td>\2</td></tr>,I

# usage uses full row
s,^   \(\[.*\)$,<tr><td colspan=\"2\">\1</td></tr>,I

# version uses full row
s,^   [0-9].*$,<tr><td colspan=\"2\">\0</td></tr>,g

# environment variables and global options have description in 2nd column
s,^   \(.*  \)\(.*\)$,<tr><td>\1</td><td>\2</td></tr>,I

# section headings use full rows
s,^\(\S.*\):\s*$,<tr><td colspan=\"2\"><h2 id=\"\1\">\1</h2></td></tr>,I
#s,^\(\S.*\)(:\|\xef\xbc\x9a)\s*$,<tr><td colspan=\"2\"><h2 id=\"\1\">\1</h2></td></tr>,I

# close </table> at the end
$a</table>
$r footer.txt
