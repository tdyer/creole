 # use the latest minitest, not the one included by default with ruby 1.9.x
 gem 'minitest'

 require 'creole'
 require 'minitest/autorun'
 require 'ruby-debug'

 # ruby -I lib test/parser_interwiki_links_test.rb 

 describe Creole::Parser do

   describe "with interwiki links" do

     # By default, Creole#creolize DOES escape link
     # and it does NOT make the link root relative
     it "#creolize" do
       Creole.os_creolize("[[company:XFVAZZZ]]").must_equal "<p><a href=\"/osn/companies\">XFVAZZZ</a></p>"
     end
     it "with raw links" do
       # debugger
        Creole.creolize("[[http://www.wikicreole.org/]]").must_equal "<p><a href=\"http://www.wikicreole.org/\">http://www.wikicreole.org/</a></p>"
     end
   end
   
 end

