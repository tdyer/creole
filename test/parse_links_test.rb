require 'creole'
require 'minitest/autorun'


# ruby -I lib test/parser_links_test.rb 

def tc(html, creole, options = {})
  generated_html = Creole.creolize(creole, options)
  # puts "creole = #{creole.inspect}"
  # puts "generated_html = #{generated_html.inspect}"
  generated_html.must_equal html
end

def tce(html, creole)
    tc(html, creole, :extensions => true)
end

describe Creole::Parser do

  it 'should parse links' do
    # Creole1.0: Links
    tc "<p><a href=\"link\">link</a></p>", "[[link]]"

    # Creole1.0: Links can appear in paragraphs (i.e. inline item)
    tc "<p>Hello, <a href=\"world\">world</a></p>", "Hello, [[world]]"

    # Creole1.0: Named links
    tc "<p><a href=\"MyBigPage\">Go to my page</a></p>", "[[MyBigPage|Go to my page]]"

    # Creole1.0: URLs
    tc "<p><a href=\"http://www.wikicreole.org/\">http://www.wikicreole.org/</a></p>", "[[http://www.wikicreole.org/]]"

    # Creole1.0: Single punctuation characters at the end of URLs
    # should not be considered a part of the URL.
    [',','.','?','!',':',';','\'','"'].each do |punct|
      esc_punct = CGI::escapeHTML(punct)
      tc "<p><a href=\"http://www.wikicreole.org/\">http://www.wikicreole.org/</a>#{esc_punct}</p>", "http://www.wikicreole.org/#{punct}"
    end
    # Creole1.0: Nameds URLs (by example)
    tc("<p><a href=\"http://www.wikicreole.org/\">Visit the WikiCreole website</a></p>",
       "[[http://www.wikicreole.org/|Visit the WikiCreole website]]")

    # WARNING: Parsing markup within a link is optional
    tc "<p><a href=\"Weird+Stuff\">**Weird** //Stuff//</a></p>", "[[Weird Stuff|**Weird** //Stuff//]]"

    # Inside bold
    tc "<p><strong><a href=\"link\">link</a></strong></p>", "**[[link]]**"

    # Whitespace inside [[ ]] should be ignored
    tc("<p><a href=\"link\">link</a></p>", "[[ link ]]")
    tc("<p><a href=\"link+me\">link me</a></p>", "[[ link me ]]")
    tc("<p><a href=\"http://dot.com/\">dot.com</a></p>", "[[  http://dot.com/ \t| \t dot.com ]]")
    tc("<p><a href=\"http://dot.com/\">dot.com</a></p>", "[[  http://dot.com/  |  dot.com ]]")
  end

  it 'should parse freestanding urls' do
    # Creole1.0: Free-standing URL's should be turned into links
    tc "<p><a href=\"http://www.wikicreole.org/\">http://www.wikicreole.org/</a></p>", "http://www.wikicreole.org/"

    # URL ending in .
    tc "<p>Text <a href=\"http://wikicreole.org\">http://wikicreole.org</a>. other text</p>", "Text http://wikicreole.org. other text"

    # URL ending in ),
    tc "<p>Text (<a href=\"http://wikicreole.org\">http://wikicreole.org</a>), other text</p>", "Text (http://wikicreole.org), other text"

    # URL ending in ).
    tc "<p>Text (<a href=\"http://wikicreole.org\">http://wikicreole.org</a>). other text</p>", "Text (http://wikicreole.org). other text"

    # URL ending in ).
    tc "<p>Text (<a href=\"http://wikicreole.org\">http://wikicreole.org</a>).</p>", "Text (http://wikicreole.org)."

    # URL ending in )
    tc "<p>Text (<a href=\"http://wikicreole.org\">http://wikicreole.org</a>)</p>", "Text (http://wikicreole.org)"
  end

end
