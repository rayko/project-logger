json.extract! resource_link, :id, :title, :link, :created_at, :updated_at
json.url resource_link_url(resource_link, format: :json)
