OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '830945113651-p5vnn8mg69km2o5i86sgj60ad9a5qdik.apps.googleusercontent.com', 'Su3xMAyff-Ge_OzOMAn9DCCv', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end
