def create_field_data
  10.times do |i|
    i += 1
    Field.create(name: "San bong #{i}", description: "Day la san bong dep", address: "Hoa Khanh, Da Nang", phone_number: "0866037302")
  end
end

def create_price_data
  3.times do |i|
    i += 1
    Price.create(name: "#{i == 1 ? "SANG" : i == 2 ? "CHIEU" : "TOI"}", price: "#{i == 1 ? "200" : i == 2 ? "300" : "400"}")
  end
end

def create_field_type_data
  10.times do |i|
    FieldType.create(field_type_name: "San #{i % 2 == 0 ? "5" : "7"}", is_availible: true, price_id: i % 2 == 0 ? 1 : 2, field_id: 3)
  end
end

create_field_data
create_price_data
create_field_type_data
