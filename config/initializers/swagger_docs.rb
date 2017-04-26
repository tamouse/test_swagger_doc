# Initialize things for swagger-docs gem

Swagger::Docs::Config.register_apis({
    "1.0" => {
      api_extension_type: :json,
      api_file_path: 'public/',
      base_path: "/"
    }
  })
