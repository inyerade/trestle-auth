module Trestle
  module Auth
    module Generators
      class ModelGenerator < ::Rails::Generators::Base
        desc "Creates an Administrator model for use with trestle-auth"

        argument :name, type: :string, default: "Administrator"

        def create_model
          generate "model", name, "email:string password_digest:string first_name:string last_name:string remember_token:string remember_token_expires_at:datetime password_reset_token:string password_reset_sent_at:datetime"
        end

        def inject_model_methods
          inject_into_file "app/models/#{name.underscore}.rb", "  include Trestle::Auth::ModelMethods\n  include Trestle::Auth::ModelMethods::Rememberable\n  include Trestle::Auth::ModelMethods::Recoverable\n", before: /^end/
        end
      end
    end
  end
end
