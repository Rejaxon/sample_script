##
# 一括置換ツール
# 
# TARGET_FOLDER配下のファイルを全て探索し、指定の拡張子ファイルにのみ文字列の置換処理を行う
# 
##

TARGET_FOLDER   = '/home/xxxxxx/'
TARGET_EXT      = ".html"
FILE_ENCODING   = Encoding::UTF_8

KEYWORDS = {
  '"img/'   => '"sp/img/'
}

require 'find'

def create_filelist(target_folder, target_ext)
  filelist = []
  Find.find(target_folder) do |fpath|
    next if File.extname(fpath) != target_ext
    filelist << fpath
  end
  filelist
end

def file_mod(filepath, encoding)
  old_str = File.read(filepath, :encoding => encoding)
  new_str = yield old_str
  File.write(filepath, new_str)
end

def replace_keywords(filepath, encoding)
  file_mod(filepath, encoding) do |str|
    KEYWORDS.each do |key, val|
      pattern = key.is_a?(Regexp) ? Regexp.new(key.to_s.encode(encoding)) : key.to_s.encode(encoding)
      replacement = val.encode(encoding)
      str = str.gsub!(pattern, replacement)
    end
    str
  end
end

def check_param
  raise 'No exist folder settign.'    if TARGET_FOLDER == ''
  raise 'No exist extention setting.' if TARGET_EXT == ''
  raise 'No exist keywords.' if KEYWORDS.empty?
end

def main
  check_param
  filelist = create_filelist(TARGET_FOLDER, TARGET_EXT)
  return if filelist.nil? || filelist.empty?
  filelist.each do |filepath|
    replace_keywords(filepath, FILE_ENCODING)
  end
end

main()
