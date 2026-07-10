module Trestle
  module Auth
    class Configuration
      class AnyLogin
        include Configurable

        option :enabled, false
        option :show_on_login_page, true
        option :show_on_admin_layout, true
      end
    end
  end
end
