json.array!(@exclusions) do |exclusion|
  json.extract! exclusion, :id
  json.url exclusion_url(exclusion, format: :json)
end
