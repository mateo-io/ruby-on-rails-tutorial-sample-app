Rake::TestTask.new :tapout do |t|
  rpt = ENV['rpt'] || 'runtime'

  t.libs << "test"
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = false
  t.options = " - --tapy | tapout #{rpt}"
end