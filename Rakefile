task :default => :test

 desc 'Run tests with minitest'
task :test do |t|
  FileList['test/*_test.rb'].each do |f|
    sh "ruby -Ilib:test #{f}"
  end
end
