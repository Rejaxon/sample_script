module Encryptor
  extend ActiveSupport::Concern

  included do |base|
    base.extend ClassMethods
    unless ENV['ENCRYPT_SECRET_TOKEN'] && ENV['ENCRYPT_SECRET_TOKEN'].length >= 32
      raise '環境変数 ENCRYPT_SECRET_TOKENを32文字指定してください.' unless ENV['ENCRYPT_SECRET_TOKEN']
    end
    @@encryptor = ActiveSupport::MessageEncryptor.new(ENV['ENCRYPT_SECRET_TOKEN'])
  end

  module ClassMethods
    def attr_enctypted(*syms)
      syms.each do |sym|
        class_eval(<<-EOS, __FILE__, __LINE__ + 1)
          def #{sym}=(value)
            value = @@encryptor.encrypt_and_sign(value) if value.is_a?(String)
            super(value)
          end

          def #{sym}
            value = super
            value.is_a?(String) ? (@@encryptor.decrypt_and_verify(value) rescue value) : value
          end
        EOS
      end
    end
  end

end
