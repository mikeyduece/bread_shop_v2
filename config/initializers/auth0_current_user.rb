# Add your Auth0 audience and domain here to ensure that the gem can authenticate the request against your app

Auth0CurrentUser.config do |c|
  c.auth0_domain = 'breadshop-development.us.auth0.com'
  c.auth0_audience = 'breadshop.com'
end
