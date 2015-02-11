require 'fileutils'
Dir.glob("**/*.rb") do |filename|
  newname = filename.gsub(' ', '_')
  FileUtils.mv(filename, newname)
end
