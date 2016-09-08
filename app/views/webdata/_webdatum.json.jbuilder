json.extract! webdatum, :id, :url, :title, :webdata, :created_at, :updated_at
json.url webdatum_url(webdatum, format: :json)