# HtmlDocument
Perl module to build simple html documents in memory and save them to disk.

Use this perl package to create a html document.
It will create an empty html when instantiated and you
may use methods to append more html to it. You cannot insert elements, only append!

Supported html elements are: paragraphs, headings, tables, anchors, breaks, horizontal rulers.

It has special features concerning anchors, see the detailed description below.

``HtmlDocument->new([title]);``
Create a new html document, give optionally a title (can also be set later).
The default character set is utf-8.

``get_html()``
Returns the so far created html document as a string.

``add_anchor(<anchor>)``
Add an invisible anchor at the current position.

``add_br()``
Add a break.

``set_charset(<mycharset>)``
Add a <meta> tag that defines the character set for this html document. Default is utf-8.

``add_heading(<level>, <text> [, <anchor>])``
Add a heading to the html document. Optionally, you can give it a named anchor.

``add_hr()``
Add a horizontal ruler.

``add_html(<html>)``

``add_link(<link>, <text>)``

``add_local_anchor(<anchor>, <text>)``

``set_local_anchor_list()``

``add_paragraph(<type>, <text>)``

``add_remark(<remark>)``

``add_table(<ref_to_array>, <element_delimiter>, <col_align>, <title_rows> [, <caption>])``

``set_title(<mytitle>)``

``save2file(<complete_path> [, <compress_command>])``
{ "xz" | "bzip2" | "gzip" }

The html document ist created as a string, containing an arbitrary
number of html elements that you append to the string. When you
request the html, the string is enclosed in html head and body and
returned.

This does NOT cover ANY html tags and is not a replacement for
html itself. The user still need to know about html and can add
arbitrary html using the add_html() method.
