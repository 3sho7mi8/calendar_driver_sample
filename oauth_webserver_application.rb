require 'bundler/setup'
require 'pry'
require 'dotenv'
require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'

binding.pry
client_secrets = Google::APIClient::ClientSecrets.load
auth_client = client_secrets.to_authorization
auth_client.update!(
  :scope => 'https://www.googleapis.com/auth/drive.metadata.readonly',
  :redirect_uri => 'http://www.example.com/oauth2callback',
  :additional_parameters => {
    "access_type" => "offline",         # offline access
    "include_granted_scopes" => "true"  # incremental auth
  }
)

