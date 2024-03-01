json.extract! project, :id, :name, :codename, :description, :status, :locked, :locked_at, :created_at, :updated_at
json.url project_url(project, format: :json)
