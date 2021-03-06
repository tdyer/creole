 # use the latest minitest, not the one included by default with ruby 1.9.x
 gem 'minitest'

 require 'creole'
 require 'minitest/autorun'
 require 'ruby-debug'

# ruby -I lib test/parser_nested_links_test.rb 

 describe Creole::Parser do

   let(:nested_link) { "[[path_seg1|path_seg2|some content]]"}
   let(:escaped_link_result) { "<p><a href=\"osn/path_seg1%2Fpath_seg2\">some content</a></p>" }
   let(:unescaped_link_result) { "<p><a href=\"osn/path_seg1/path_seg2\">some content</a></p>" }
   let(:root_escaped_link_result) { "<p><a href=\"/osn/path_seg1%2Fpath_seg2\">some content</a></p>" }
   let(:root_unescaped_link_result) { "<p><a href=\"/osn/path_seg1/path_seg2\">some content</a></p>" }

   describe "with nested links" do

     # By default, Creole#creolize DOES escape link
     # and it does NOT make the link root relative
     it "#creolize" do
       # debugger
       Creole.creolize(nested_link).must_equal "<p><a href=\"path_seg1%2Fpath_seg2\">some content</a></p>"
     end

     # same as above
     it "#creolize with escape" do
       Creole.creolize(nested_link, :no_escape => false).must_equal "<p><a href=\"path_seg1%2Fpath_seg2\">some content</a></p>"
     end

     it "#creolize without escape" do
       Creole.creolize(nested_link, :no_escape => true).must_equal "<p><a href=\"path_seg1/path_seg2\">some content</a></p>"
     end

     it "#creolize with escape and root relative" do
       Creole.creolize(nested_link, :root_link => true).must_equal "<p><a href=\"/path_seg1%2Fpath_seg2\">some content</a></p>"
     end

     # By default, Creole#os_creolize does NOT escape link
     # and it DOES make the link root relative
     it "#os_creolize" do
       # debugger
       Creole.os_creolize(nested_link).must_equal root_unescaped_link_result
     end

     # same as above
     it "#os_creolize without escape and root relative" do
       Creole.os_creolize(nested_link, :no_escape => true).must_equal root_unescaped_link_result

     end

     it "#os_creolize with escape and root relative" do
       Creole.os_creolize(nested_link, :no_escape => false).must_equal root_escaped_link_result
     end

     it "#os_creolize with escape and not root relative" do
        Creole.os_creolize(nested_link, :no_escape => false, :root_link => false).must_equal escaped_link_result
      end
   end

   it "#os_creolize with spaces in path separators " do
     Creole.os_creolize("[[path seg1|path seg2|some content]]").must_equal "<p><a href=\"/osn/path seg1/path seg2\">some content</a></p>"

     # loose the leading and trailing spaces in the path segments
     Creole.os_creolize("[[  path seg1|path seg2 |some content]]").must_equal "<p><a href=\"/osn/path seg1/path seg2\">some content</a></p>"
     # again
     Creole.os_creolize("[[  path seg1 | path seg2 |some content]]").must_equal "<p><a href=\"/osn/path seg1/path seg2\">some content</a></p>"
   end

   it "#os_creolize with many path segments" do
     Creole.os_creolize('[[path_seg1| path segment2 |pathseg3| link content]]').must_equal "<p><a href=\"/osn/path_seg1/path segment2/pathseg3\"> link content</a></p>"
   end
   
 end

