module Extentions
  class ApiResponder < ActionController::Responder
    def json_resource_errors
      {:message => resource.errors.full_messages.first }
    end
  end
end
