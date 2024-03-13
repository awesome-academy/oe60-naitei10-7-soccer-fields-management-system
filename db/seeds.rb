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
    field_type = FieldType.create(field_type_name: "San #{i % 2 == 0 ? "5" : "7"}", is_availible: true, field_id: 2)
    create_price_data(field_type.id)
  end
end

# create_field_data
# create_price_data
create_field_type_data
