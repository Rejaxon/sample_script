module Extentions
  module StringExtention
    String.class_eval do
      # 文字列が数値のみかチェック.
      def numeric?
        self.present? && self =~ /^[0-9]+$/
      end
      
      # 文字列をboolean型に変換。変換失敗はnil
      def to_b
        return true  if self == "true" || self == "TRUE"
        return false if self == "false" || self == "FALSE"
        nil
      end
      
      # 文字列をboolean型に変換。変換失敗はエラー
      def to_b!
        result = self.to_b
        raise "Method arg 'self' is #{self}" if result.nil?
        result
      end
    
    end
  end
end
