require 'find'
require 'nokogiri'
require 'logger'

##################################################################################################################
# 
# デザイナー、コーダーが造ったHTMLを erb向けに変換するためのツールとして作成
# 下記、各定数を対象HTMLに合わせて、CSSセレクタ、変換文字列を変更して使うこと
# 
# command:
#     ruby html_converter.rb
#     ruby html_converter.rb > [出力ログファイル]
# 
# setting constant
#     TARGET_FOLDER    : 指定のォルダ配下のファイルが全て対象
#     TARGET_EXT       : 処理対象のファイル拡張子
#     CONVERT_EXT      : 変換後の文字列をファイル出力する時の拡張子
#     FILE_ENCODING    : utf-8.他は動作未確認.
#     OUTPUT_NODES     : 指定のNodeを１つのファイルに出力
#     CONVERT_TAGS     : タグを指定の文字列に変換。タグはCSSで指定。ただし、CSSでできない指定のNodeの２つ上の親などを指定可能。
#     KEYWORDS         : 文字列変換を実施する場合に指定
#     CONTENT_FOR_TITLE: content_for helperメソッドにより、タイトル指定をerbに埋め込む
# 
##################################################################################################################

#TARGET_FOLDER   = '/home/r-sakon/project/anshin-cardloan/app/views/'
TARGET_FOLDER   = '/home/r-sakon/sh/'
TARGET_EXT      = '.html'
CONVERT_EXT     = '.erb'
FILE_ENCODING   = Encoding::UTF_8

# 指定したNodeだけを連続してテキスト出力し、erbファイルを構成する
OUTPUT_NODES = [
  # upは、parentメソッドで登る回数
  { css: 'div.bannerBg > div.container', up: 1 },
  { css: 'div.container > div.row-fluid > div.span7.pr20', up: 2 },
  
  # for sp
  { css: 'body > div.bodyWRapper > div.content > div.row-fluid > div.span10', up: 2 }
]

# 各OUTPUT_NODESに対してのCSSセレクタを定義
CONVERT_TAGS = [
  # for sp
  { css: "div.row-fluid > div.span10 > div.row-fluid.mb20", up: 0, val: '<%= partial "layouts/basic_menu.erb" %>'},
  # for pc
  { css: "div.row-fluid > div.span7 > div.row-fluid.mb20", up: 0, val: '<%= partial "layouts/basic_menu.erb" %>'}
]

# Nodeの文字列出力結果に対する文字列変換処理
KEYWORDS = {
  # 変換対象（文字列、Regexp） => 変換後の文字列
  /<!-- *start *\/part\/(.*?)\.erb *.*?-->.*?<!-- *end *.*?-->/m => '<%= partial "layouts/\1.erb" %>'
}

# content_for :titleを挿入
CONTENT_FOR_TITLE = <<CFT
<% content_for :title do -%>
  <%= 'CONTENT_FOR_TITLE' -%>
<% end -%>
CFT

################################### 処理対象別に変更必要な範囲終了 ###################################################

# Logger
$log = Logger.new(STDOUT)
$log.level = Logger::INFO


def select_files
  filelist = []
  Find.find(TARGET_FOLDER) do |fpath|
    next if File.extname(fpath) != TARGET_EXT
    filelist << fpath
  end
  filelist
end

def convert_file(filepath)
  old_str = File.read(filepath, :encoding => FILE_ENCODING)
  new_str = yield old_str
  new_path = filepath.gsub(TARGET_EXT, CONVERT_EXT)
  File.write(new_path, new_str)
end


def check_param
  raise 'No exist folder setting.'    if TARGET_FOLDER.nil? or TARGET_FOLDER.empty?
  raise 'No exist extention setting.' if TARGET_EXT.nil? or TARGET_EXT.empty? or CONVERT_EXT.nil? or CONVERT_EXT.empty?
  raise 'No exist encoding setting.'  if FILE_ENCODING.nil?
  raise 'No exist title setting.'  if CONTENT_FOR_TITLE.nil? or CONTENT_FOR_TITLE.empty?
end


def convert_tags!(node)
  CONVERT_TAGS.each do |hash|
    target_node = extract_one_node(node, hash[:css], hash[:up])
    target_node.replace hash[:val] if !target_node
  end
end


def add_title!(doc_str, title)
  inserted = CONTENT_FOR_TITLE.gsub('CONTENT_FOR_TITLE', title)
  inserted << "\n\n"
  doc_str.insert(0, inserted)
end


def script_info(file, doc)
  nodeset = doc.css('script');
  info = []
  nodeset.each do |s|
    s_content = s.text
    info << s unless s_content.nil? or s_content.empty?
  end
  return if info.empty?
  $log.info("-------------------------------------------")
  $log.info("Script tag information.")
  $log.info(file)
  $log.info(doc.title)
  info.each { |i| $log.info(i.to_html)}
  $log.info("-------------------------------------------")
end

def replace_keywords!(str)
  KEYWORDS.each do |key, val|
    pattern = key.is_a?(Regexp) ? Regexp.new(key.to_s) : key.to_s
    str = str.gsub!(pattern, val)
  end
end

def extract_one_node(doc, css, up = 0)
  nodeset = doc.css(css)
  raise if nodeset.size > 1
  return if nodeset.size == 0
  result = nodeset.first
  up.times {result = result.parent}
  result
end

def create_erb_text(doc)
  result = ''
  OUTPUT_NODES.each do |hash|
    node = extract_one_node(doc, hash[:css], hash[:up])
    next if node.nil?
    
    convert_tags!(node)
    result << node.to_html # utf-8
    result << "\n"
  end
  replace_keywords!(result)
  add_title!(result, doc.title)
  result
end

def main
  check_param
  files = select_files
  files.each do |f|
    begin
      convert_file(f) do |f_str|
        doc = Nokogiri::HTML(f_str)
        script_info(f, doc)
        create_erb_text(doc)
      end
    rescue => ex
      $log.error "Error. #{f}"
      $log.error ex.backtrace.join("\n")
    end
  end
end

main