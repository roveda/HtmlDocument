#
# HtmlDocumentTest.pl  -  Test the HtmlDocument.pm perl module
#
# Description:
#
# This script uses the HtmlDocument.pm perl module, creates an html document 
# containing several html elements that are supported by the perl module
# and saves it to disk as html and compressed.
#
# ---------------------------------------------------------
# Copyright 2016, roveda
#
# HtmlDocumentTest.pl is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# HtmlDocumentTest.pl is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with HtmlDocumentTest.pl. If not, see <http://www.gnu.org/licenses/>.
#
#
# ---------------------------------------------------------
# Dependencies:
#
#   perl v5.6.0
#
# ---------------------------------------------------------
# Installation:
#
#   No installation necessary. 
#
# ---------------------------------------------------------
# Versions:
#
# 2016-07-13, 0.01, roveda
#   Created.
#
# ---------------------------------------------------------


use strict;
use warnings;

my $VERSION = 0.01;

use lib ".";
use Misc 0.36;

# That perl module is tested:
use HtmlDocument;

# Instantiate a new html document
my $html = HtmlDocument->new("HtmlDocument_Test_Page");

$html->add_remark("Created: " . iso_datetime());

$html->add_heading("1", "This is the Test Page for the HtmlDocument perl module", "_default_");

# At this place, local anchors (as table of contents) shall be inserted.
$html->set_local_anchor_list();

$html->add_heading("2", "Lorem Ipsum", "_default_");

$html->add_paragraph("p", "Lorem ipsum dolor sit amet, <tt>consetetur sadipscing elitr</tt>, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, <b>sed diam voluptua</b>. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.");

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
$t .= ".html";

# Save the file as html
# my $f = $html->save2file("./$t");

# Save the file, compress with xz
my $f = $html->save2file("./$t", "xz", "force");

# Show the changed file name
print "Saved as file: $f\n";

