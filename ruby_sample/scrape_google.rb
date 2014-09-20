require 'rubygems'
require 'mechanize'

# debug
# require 'awesome_print'

unless ARGV[0] && !ARGV[1]
  puts "引数に検索条件を１つ指定してください。複数のキーワードは、半角+繋ぎです。"
  exit 1
end
keyword = ARGV[0]
PAGE_SIZE = 10
URL = "https://www.google.co.jp/"
PAGE_CNT = 10

a = Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac Safari'
}

a.get(URL) do |page|
  search_result = page.form_with(action: '/search') do |search|
    search.q = keyword
  end.submit
  
  PAGE_CNT.times do |pindex|
    search_result.search("li.g h3.r a").each_with_index do |node, i|
      # node is Nokogiri::XML::Element < Nokogiri::XML::Node
      s_num = pindex * PAGE_SIZE + 1
      node['href'] =~ /url\?q=(.*?)&/
      puts %(#{s_num + i},"#{node.content}", "#{$1}")
    end
    break if pindex + 1 == PAGE_SIZE
    
    nlink_node = search_result.search("table#nav td.b a").last
    nlink = Mechanize::Page::Link.new(nlink_node, a, search_result)
    search_result = nlink.click
  end
end
