Trestle.configure do |config|
  config.hook("stylesheets") do
    stylesheet_link_tag("trestle/auth/userbox")
  end

  config.hook("view.header") do
    render "trestle/auth/userbox"
  end

  config.hook("view.footer") do
    if Trestle.config.auth.any_login.enabled && Trestle.config.auth.any_login.show_on_admin_layout
      any_login_here if defined?(AnyLogin)
    end
  end
end
