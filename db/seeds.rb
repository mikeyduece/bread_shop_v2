%w[Lean Soft Slack Rich Sweet].each do |family_name|
  Family.find_or_create_by(name: family_name)
end