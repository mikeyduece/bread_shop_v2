puts '#################################'
puts 'Creating Families'
%w[lean soft slack rich sweet].each { |family_name| Family.find_or_create_by(name: family_name) }

puts '#################################'
puts 'Creating Categories'
%w[sweetener fat flour water].each { |name| Category.find_or_create_by(name: name) }
