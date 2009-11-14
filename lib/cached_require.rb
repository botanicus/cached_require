#!/usr/bin/env ruby
# encoding: utf-8

require "find"

class Loader
  def find(fragment)
    if fragment.start_with?("/") # TODO: windows
      File.expand_path(fragment) # because of ../ etc
    else
      self.filemap[fragment]
    end
  end
  alias_method :[], :find

  def require(fragment)
    path = self.find(fragment)
    if path.nil?
      raise LoadError, "No such file: #{fragment}"
    else
      Kernel.__require__(path)
    end
  end
  
  def load(fragment)
    Kernel.load fragment
  end
  
  def reload
    @filemap = nil
    self.filemap
  end
  
  protected
  # hash["foo"] || hash["foo.rb"] is the same
  def hash
    Hash.new do |hash, key|
      if key.end_with?(".rb")
        hash[key.sub(/\.rb$/, "")]
      end
    end
  end
  
  # {"rango/exts" => fullpath}
  def filemap
    @filemap ||= begin
      # why reverse: if we have multiple versions of a library
      $:.uniq.reverse.inject(self.hash) do |hash, directory|
        begin
          Find.find(directory) do |file|
            if file.match(/\.rb$/)
              relative = file.sub(/#{directory}\/(.+)\.rb$/, '\1')
              hash[relative] = File.expand_path(file)
            end
          end
        rescue Errno::ENOENT
          # just skip it
        end
        hash
      end
    end
  end
end

class << $:
  def []=(value)
    super.tap { self.hook }
  end

  def push(*args)
    super.tap { self.hook }
  end
  
  def unshift
    super.tap { self.hook }
  end
  
  def shift
    super.tap { self.hook }
  end
  
  def pop
    super.tap { self.hook }
  end
  
  def insert(*args)
    super.tap { self.hook }
  end
  
  def reverse!
    super.tap { self.hook }
  end
  
  def replace
    super.tap { self.hook }
  end
  
  def sort!
    super.tap { self.hook }
  end
  
  def collect!
    super.tap { self.hook }
  end
  
  def map!
    super.tap { self.hook }
  end
  
  def delete(*args)
    super.tap { self.hook }
  end
  
  def delete_at(*args)
    super.tap { self.hook }
  end
  
  def delete_if
    super.tap { self.hook }
  end
  
  def uniq!
    super.tap { self.hook }
  end
  
  def compact!
    super.tap { self.hook }
  end
  
  def flatten!
    super.tap { self.hook }
  end
  
  def shuffle!
    super.tap { self.hook }
  end
  
  protected
  def hook
    $LOADER ||= Loader.new
    $LOADER.reload
  end
end

module Kernel
  if self.instance_methods.include?(:__require__)
    alias_method :__require__, :require
    def require(fragment)
      $LOADER ||= Loader.new
      $LOADER.require fragment
    end
  end
end

if __FILE__ == $0
  require "irb"
  begin
    require "irb/completion"
  rescue LoadError
    warn "Completion disabled"
  end
  IRB.start
end
