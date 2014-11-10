module Sprockets
  module SkipFiles
    def evaluate(path, options = {})
      if path.to_s[/\.(gzip|map)$/]
        STDERR.puts "#{path}: skipped"
        ''
      else
        STDERR.puts "#{path}: super"
        super
      end
    end
  end
end

Sprockets::Context.send(:prepend, Sprockets::SkipFiles)

