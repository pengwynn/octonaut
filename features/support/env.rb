require 'aruba/cucumber'

ENV['PATH'] = "#{File.expand_path(File.dirname(__FILE__) + '/../../bin')}#{File::PATH_SEPARATOR}#{ENV['PATH']}"
LIB_DIR = File.join(File.expand_path(File.dirname(__FILE__)),'..','..','lib')

GLI_GEMSET = 'gli-testing'
TMP_PATH = 'tmp/aruba'

Before do
  # Using "announce" causes massive warnings on 1.9.2
  @dirs = [TMP_PATH]
  @puts = true
  @original_rubylib = ENV['RUBYLIB']
  ENV['RUBYLIB'] = LIB_DIR + File::PATH_SEPARATOR + ENV['RUBYLIB'].to_s

  @original_path = ENV['PATH'].split(File::PATH_SEPARATOR)
  @original_home = ENV['HOME']
  new_home = "/tmp/fakehome"
  ENV['HOME'] = new_home
end

After do
  ENV['RUBYLIB'] = @original_rubylib

  # todo_app_dir = File.join(TMP_PATH,'todo')
  # if File.exists? todo_app_dir
  #   FileUtils.rm_rf(todo_app_dir)
  # end
  ENV['PATH'] = @original_path.join(File::PATH_SEPARATOR)
  ENV['HOME'] = @original_home
end


