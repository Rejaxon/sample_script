module Extentions
  module HashExtention
    Hash.class_eval do

      def has_keys?(*keys)
        return false if keys.blank?
        keys = keys[0] if keys[0].is_a?(Array)
        keys.each do |key|
          if self[key].blank? || self[key] == "null" #multipart/form-data形式など空の場合にある
            return false
          end
        end
        true
      end
      
      def compact_more
        self.select { |_, value| value.present? }
      end
      
      def compact_more!
        self.select! { |_, value| value.present? }
      end
    end
  end
end
