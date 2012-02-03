require 'creole/parser'
require 'creole/version'

module Creole
  # Convert the argument in Creole format to HTML and return the
  # result. Example:
  #
  #    Creole.creolize("**Hello //World//**")
  #        #=> "<p><strong>Hello <em>World</em></strong></p>"
  #
  # This is an alias for calling Creole#parse:
  #    Creole.new(text).to_html
  def self.creolize(text, options = {})
    Parser.new(text, options).to_html
  end

  # Same as above BUT links do NOT get escaped AND links are root
  # relative, i.e. they have a leading slash '/'
  def self.os_creolize(text, options = {})
    opts = { :root_link => true, :no_escape => true, :prefix => 'osn'}.merge(options)
    Parser.new(text, opts).to_html
  end
end
