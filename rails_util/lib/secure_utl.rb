
require 'digest/sha2'

class SecureUtl
  
  # 仮パスワード発行
  def self.sample_pass(len = 8)
    [*0..9, *'a'..'z', *'A'..'Z'].sample(len).join()
  end
  
  # SHA-256ハッシュ値（32バイト）を指定の文字列から生成
  def self.hexdigest(str)
    Digest::SHA256.hexdigest(str)
  end
end

