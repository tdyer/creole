 # use the latest minitest, not the one included by default with ruby 1.9.x
 gem 'minitest'

 require 'creole'
 require 'minitest/autorun'
 require 'ruby-debug'

 # ruby -I lib test/parser_nested_links_test.rb 

 describe Creole::Parser do

   let(:nested_link) { "[[path_seg1|path_seg2|some content]]"}

   describe "with nested links" do

     # Creole#creolize escapes by default
     it "#creolize" do
       # debugger
       Creole.creolize(nested_link).must_equal "<p><a href=\"path_seg1%2Fpath_seg2\">some content</a></p>"            
     end
     it "#creolize with escape" do
       Creole.creolize(nested_link, :no_escape => false).must_equal "<p><a href=\"path_seg1%2Fpath_seg2\">some content</a></p>"      
     end

     it "#creolize without escape" do
       Creole.creolize(nested_link, :no_escape => true).must_equal "<p><a href=\"path_seg1/path_seg2\">some content</a></p>"      

     end

     # Creole#os_creolize does NOT escape by default
     it "#os_creolize" do
       # debugger
       Creole.os_creolize(nested_link).must_equal "<p><a href=\"path_seg1/path_seg2\">some content</a></p>"            
     end
     it "#os_creolize without escape" do
       Creole.os_creolize(nested_link, :no_escape => true).must_equal "<p><a href=\"path_seg1/path_seg2\">some content</a></p>"      

     end
     it "#os_creolize with escape" do
       Creole.os_creolize(nested_link, :no_escape => false).must_equal "<p><a href=\"path_seg1%2Fpath_seg2\">some content</a></p>"      
     end

   end
   
 end

