module Extentions
  module ControllerExtention
    # StrongParameterのHash KeyをSymbol化（Rubyのキーワード引数との相性を良くするため）
    ActionController::Parameters.class_eval do
      alias_method :orig_permit, :permit
      def permit(*filters)
        orig_permit(*filters).deep_symbolize_keys
      end
    end

    # respond_with拡張. validate error時のjson error messageにlocale適用
    ActionController::Responder.class_eval do
      def json_resource_errors
        { message: resource.errors.full_messages.first }
      end
    end

  end
end
