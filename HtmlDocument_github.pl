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
