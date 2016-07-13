#!/usr/bin/env ruby
#
# List all android apk names and used library information in CSV format
# by searching AndroidManifest.xml and Android.mk.
#
# Usage:
#   $ cd <project_root>
#   $ ruby android-list-apks.rb <search_path>
#
# [2010-05-11] Masatoshi.Ohta
#
def enum_files(dir_path, filename)
  Dir.foreach(dir_path) do |x|
    next if x == "." or x == ".."
    new_path = File.join(dir_path, x)
    if not File.directory? new_path then
      if x == filename
        yield new_path
      end
    else
      enum_files(new_path, filename) do |x|
        yield x
      end
    end
  end
end

def get_apk_name_from_androidmk(androidmk_path)
  if File.exist?(androidmk_path)
    File.foreach(androidmk_path) do |line|
      if /LOCAL_PACKAGE_NAME *:= *(.*)/ =~ line
        return $1
      end
    end
  end
  return ""
end

path = ARGV[0] ? ARGV[0] : "."
if not File.directory? path
  STDERR.puts "Error: '#{path}' is not a directory."
  exit
end

puts "APK package,Java package,Dir,Using"

require "rexml/document"
include REXML

enum_files(path, "AndroidManifest.xml") do |x|
  doc = Document.new(File.new(x))

  # Directory name
  dirpath = File.dirname(x)

  # Android.mk path
  mkpath = File.join(dirpath, "Android.mk")
  apk_name = get_apk_name_from_androidmk(mkpath)

  # Package name
  firstmodel = XPath.first(doc, "//manifest")

  print "#{apk_name}," 
  print "#{firstmodel.attributes['package']},"
  print "#{dirpath},"

  # Used libraries
  XPath.each(doc, "//uses-library") do |element|
    print "#{element.attributes['android:name']} "
  end

  print "\n"
end

