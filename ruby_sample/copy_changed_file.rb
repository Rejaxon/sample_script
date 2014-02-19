# EclipseのPatchファイルを元に変更のあったファイルだけをフォルダ構成を維持した状態で指定のディレクトリに出力します。
#
# command:
# 	copy_changed_file.rb [PATCHファイル絶対パス]
#
# setting:
# 	OUTPUT_PATH	：ソースファイル出力場所。フォルダ構成を維持して出力する
# 	SOURCE_PATH	：ソースファイルのルートディレクトリ
# 	PATCH_PATH	：PATCHが格納されているフォルダ。引数を指定しない場合に本フォルダの最新パッチが自動選択される
# 	PATCH_EXT		：PATCHの拡張子

OUTPUT_PATH = 'C:/Work/'
SOURCE_PATH = 'C:/Develop/workspace/'
PATCH_PATH = 'C:/Work/'
PATCH_EXT = '.patch'

require 'fileutils'
require 'find'

def extract_filelist(patch_filepath)
	filelist = []
	grepped = File.readlines(patch_filepath).grep(/^Index: /)
	grepped.each {|hit| filelist << hit.slice(7..-1).chomp }
	filelist
end

def output(filelist)
	filelist.each do |path|
		dest_path = OUTPUT_PATH + path
		src_path = SOURCE_PATH + path
		if !File.exists?(src_path)
			p "Maybe this file is deleted. You confirm. path: #{src_path}"
			next
		end
		dest_dir = File.dirname(dest_path)
		FileUtils.mkdir_p(dest_dir) unless File.exists?(dest_dir)
		FileUtils.copy_file(src_path, dest_path)
	end
end

def resolve_filepath(specified_filepath)
	filepath = specified_filepath
	if filepath == nil
		found_file = []
		Find.find(PATCH_PATH) do |fpath|
			next unless fpath.include?(PATCH_EXT)
			found_file[0] = fpath if FileUtils.uptodate?(fpath, found_file)
			filepath = found_file[0]
		end
	end
	filepath
end

def main
	file_path = resolve_filepath(ARGV[0])
	filelist = extract_filelist(file_path)
	output(filelist)
end

main()
