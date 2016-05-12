# config/initializers/devise.rb
#
# config.warden do |manager|
#   manager.failure_app = Extentions::DeviseCustomFailure
# end
module Extentions
  class DeviseCustomFailure < Devise::FailureApp

    def http_auth_body
      return i18n_message unless request_format
      method = "to_#{request_format}"
      # if method == "to_xml"
      #   { error: i18n_message }.to_xml(root: "errors")
      if {}.respond_to?(method) # json用 error messageはここに来る
        { message: i18n_message.presence || 'ログイン、もしくはアカウント作成してください.' }.send(method)
      else
        i18n_message
      end
    end
  end
end
