json.extract! idea, :id, :name, :description, :author, :organization, :url, :created_at, :updated_at
json.url idea_url(idea, format: :json)
