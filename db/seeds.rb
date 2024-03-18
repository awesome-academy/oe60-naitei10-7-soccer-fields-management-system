def create_field_data
  10.times do |i|
    i += 1
    Field.create(name: "San bong #{i}", description: "Day la san bong dep", address: "Hoa Khanh, Da Nang", phone_number: "0866037302")
  end
end

def create_price_data (id)
  3.times do |i|
    i += 1
    Price.create(name: "#{i == 1 ? "M" : i == 2 ? "A" : "E"}", price: "#{i == 1 ? "200" : i == 2 ? "300" : "400"}", field_type_id: id)
  end
end

def create_field_type_data
  30.times do |i|
    field_type = FieldType.create(field_type_name: "San #{i % 2 == 0 ? "5" : "7"}", is_availible: true, field_id: 3)
    create_price_data(field_type.id)
  end
end

def create_users
  10.times do |n|
    first_name = Faker::Name.first_name
    last_name = Faker::Name.last_name
    email = Faker::Internet.email
    phone_number = Faker::PhoneNumber.phone_number
    password = "Password@1"
    role = 3
    is_active = true # You can adjust this as needed
    activated = true # You can adjust this as needed

    User.create!(
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone_number: phone_number,
      password: password,
      role: role,
      is_active: is_active,
      activated: activated,
      activated_at: Time.zone.now # Assuming activated immediately
    )
  end
end

# create_field_data
# create_price_data
# create_field_type_data
create_users
