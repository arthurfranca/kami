json.array!(@specialties) do |specialty|
  json.extract! specialty, 
  json.url specialty_url(specialty, format: :json)
end
