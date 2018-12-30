require 'bundler/setup'
require 'pry'
require 'dotenv/load'
require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'

# reference: https://developers.google.com/api-client-library/ruby/auth/web-app?authuser=2
client_secrets = Google::APIClient::ClientSecrets.load
auth_client = client_secrets.to_authorization
auth_client.update!(
  :scope => 'https://www.googleapis.com/auth/drive.metadata.readonly',
  :redirect_uri => ENV['REDIRECT_URI'],
  :additional_parameters => {
    "access_type" => "offline",         # offline access
    "include_granted_scopes" => "true", # incremental auth
    "state" => "company_name"
  }
)

auth_uri = auth_client.authorization_uri.to_s
puts '出力されたURLにアクセスしてください'
puts auth_uri

puts 'CODEを入力してください'
auth_client.code = gets
auth_client.fetch_access_token!
