Rails.application.config.middleware.use OmniAuth::Builder do
  provider :identity, :on_failed_registration => IdentitiesController.action(:new)
  provider :twitter, 'kivBXFB5gE7RunUmBXgoWg', 'O8PLhMwETapHwD55AuUL4K8e27XwDb1GZI4jtj4cwg'
end
