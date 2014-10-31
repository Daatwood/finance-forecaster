json.array!(@recurrences) do |recurrence|
  json.extract! recurrence, :id
  json.url recurrence_url(recurrence, format: :json)
end
