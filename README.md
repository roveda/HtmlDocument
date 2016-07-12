## HtmlDocument
Perl module to build simple html documents in memory and save them to disk.

Use this perl package to create a html document.
It will create an empty html when instantiated and you
may use methods to append more html to it. You cannot insert elements, only append!

Supported html elements are: paragraphs, headings, tables, anchors, breaks, horizontal rulers.

It has special features concerning anchors, see the detailed description below.

    HtmlDocument->new([title]);
Create a new html document, give optionally a title (can also be set later).
The default character set is utf-8.

    add_anchor(<anchor>)
Add an invisible anchor at the current position.
You can place a link to this anchor anywhere in the html document. 
Remember to use "#anchor" as link destination.

    add_br()
Add a break.

    add_goto_top(<text>)
Add a link that scrolls the html document to the top of the document.
The text is displayed as link. Typically used for 'Up' or 'go to top'.

    add_heading(<LEVEL>, <text> [, <anchor>])
Add a heading to the html document. Optionally, you can give it a named anchor.
If anchor is given, it will insert an attribute `<hLEVEL id="anchor">text</hLEVEL>`
If you use `_default_` as anchor, the anchor will be
automatically derived from the text, all lowercase, blanks replaced by underscores.

    add_hr()
Add a horizontal ruler.

    add_html(<html>)
Add arbitrary html code to the html document.

    add_link(<link>, <text>)
Add a link to the html document.

    add_local_anchor(<anchor>, <text>)
An anchor is set at the current position, the text is filed in an array for later use.
It will be replaced during output of the html at the position, where the local anchor list
is to be placed. See `set_local_anchor_list()`.

    add_paragraph(<type>, <text>)
Add a paragraph of any type. Use e.g. 'p' or 'pre' as type.

    add_remark(<remark>)
Add a remark to the html document.

    add_table(<ref_to_array>, <element_delimiter>, <col_align>, <title_rows> [, <caption>])
Add a table to the html document. You must provide a reference to an array

The array should contain lines of text like: ('!' as delimiter expected):
```
value1          !   value in col 2  !  value in col 3 ! etc
value2 in col 1 !                   !  xyz            ! even more
3               !   4               !          5      ! what the heck...
```
The col_align is a string containing one character ('L', 'C' or 'R') for each table 
column which defines its respective alignment.
The number of title rows define the number of rows, that are enclosed in 'th' tags
instead of 'td' tags.
The table caption is optional.

    get_html()
Returns the so far created html document as a string.

    get_title()
Returns the title of the htm document, if defined.

    save2file(<complete_path> [, <compress_command> [, <force>]])
That saves the so far created html document to the given file. Compress th resulting file 
if a compression command is given. Supported are 'xz', 'bzip2' and 'gzip'. Use any value 
for force to use the '--force' argument to the compression command.

The method returns the resulting filename 
(complete path including [probably changed by compression] extension)
or undef if anything did not work. Error messages are printed to STDERR.

    set_charset(<mycharset>)
Add a <meta> tag that defines the character set for this html document. Default is utf-8.

    set_local_anchor_list()
That inserts a special remark which will be replaced by the links to **all** filed local anchors
when the html document is requested (`get_html`, `save2file`).
You may use that e.g. for a table of contents. It can be used more than once. 

    set_title(<mytitle>)
Set the title of the html document.

# General
The html document ist created as a string, containing an arbitrary
number of html elements that you append to the string. When you
request the html, the string is enclosed in html head and body and
returned.

This does NOT cover ANY html tags and is not a replacement for
the usage of html itself. The user still need to know about html and can add
arbitrary html using the add_html() method.

# Example
This is a perl snippet to demonstrate the usage of this module.
```perl
use strict;
use warnings;

use HtmlDocument;

my $html = HtmlDocument->new("HtmlDocument test page for github");

$html->add_remark("Created: " . iso_datetime());

$html->add_heading("1", "First Heading", "_default_");

$html->add_paragraph("p", "Lorem ipsum dolor sit amet, <tt>consetetur sadipscing elitr</tt>, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, <b>sed diam voluptua</b>. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.");

# At this place, local anchors (as table of contents) shall be inserted.
$html->set_local_anchor_list();

$html->add_heading("2", "Pre-Formatted Paragraph", "_default_");

$html->add_paragraph("pre", "-rw-rw-r-- 1 foo bar 0 Sep 14 18:44 chapter1.txt
-rw-rw-r-- 1 foo bar 0 Sep 14 18:44 chapter2.txt
-rw-rw-r-- 1 foo bar 0 Sep 14 18:44 chapter3.txt
-rw-rw-r-- 1 foo bar 0 Sep 14 18:49 Chapter_headings.txt
-rw-rw-r-- 1 foo bar 0 Sep 14 18:49 Preface.txt");

$html->add_goto_top("Up");

$html->add_hr();

$html->add_heading("2", "Example Measurement Result Table", "_default_");

# Simulate a bunch of values from some kind of measurement
my $results = "Batched IO (bound) vector count!40!
Batched IO (full) vector count!35!
Batched IO (space) vector count!0!
Batched IO block miss count!5977!
Batched IO buffer defrag count!15!
Batched IO double miss count!10!
Batched IO same unit count!290!
Batched IO single block count!23!
Batched IO slow jump count!0!";

# Split it up into an array of lines
my @RESULTS = split(/\n/, $results);

# Append a table, '!' as delimiter, left and right alignment, no title rows
$html->add_table(\@RESULTS, "!", "LR",0 , "Measurement results");

$html->add_goto_top("Up");

# Output the html document to screen
print $html->get_html();
print "\n";

# Get the title of the html document, use it as file name.
my $t = $html->get_title();

# Save the file, compress with xz
my $f = $html->save2file("/tmp/$t", "xz", "force");
# Show the changed file name
print "Saved as file: $f\n";
```

