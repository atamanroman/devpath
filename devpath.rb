#!/usr/bin/env ruby

require 'set'

class Path
  attr_accessor :original, :folders, :items, :stale_folders

  @@lib_exts = ['.dll', '.so', '.a', '.lib']

  def initialize()
    @original = ENV['PATH'];
    @folders = @original.split(File::PATH_SEPARATOR)
    @items = {}
    @stale_folders = []
    @folders.each do |folder|
      if(Dir.exists?(folder))
        Dir.foreach(folder) do |file|
          if(relevant?(File.expand_path(file, folder)))
              items[file] = Set.new unless items.has_key?(file)
              items[file] << folder
          end
        end
      else
        @stale_folders << folder
      end
    end
  end

  def relevant?(file)
    dir = File.directory?(file)
    exe = File.executable?(file)
    lib = @@lib_exts.include?(File.extname(file))
    return !dir && (exe || lib)
  end

  def duplicates
    items.select {|key, value| value.size > 1}
  end
end

if __FILE__ == $0
  x = Path.new()
  puts 'Path: ' + x.original.to_s
  puts 'Folders: ' + x.folders.to_s
  puts 'Stale folders: ' + x.stale_folders.to_s
  puts 'Relevant items: ' + x.items.to_s
  puts 'Duplicates: ' + x.duplicates.to_s
end
