
class Swagger::Docs::Config
  def self.transform_path(path, api_version)
    "apidocs/#{path}"
  end
end

Swagger::Docs::Config.register_apis({
  "1.0" => {:controller_base_path => "",
            :api_file_path => "public/apidocs",
            :base_path => "http://#{ENV['BASE_DOMAIN']}",
            :clean_directory => true
          }
})

Swagger::Docs::Config.base_api_controller = Api::V1::BaseController
