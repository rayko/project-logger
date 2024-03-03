json.extract! todo_item, :id, :project_id, :text, :checked, :created_at, :updated_at
json.url todo_item_url(todo_item, format: :json)
