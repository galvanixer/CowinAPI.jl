get_states_url() = "https://cdn-api.co-vin.in/api/v2/admin/location/states"
get_districts_url(state_id::Int) = "https://cdn-api.co-vin.in/api/v2/admin/location/districts/$(state_id)"
find_by_pin_url(pin::Int, date::String) = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=$(pin)&date=$(date)"
find_by_district_url(district_id::Int, date::String) ="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByDistrict?district_id=$(district_id)&date=$(date)"
calendar_by_pin_url(pin::Int, date::String) ="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByPin?pincode=$(pin)&date=$(date)"
calendar_by_district_url(district_id::Int, date::String) = "https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/calendarByDistrict?district_id=$(district_id)&date=$(date)"
download_certificate_url(beneficiary_reference_id::String) = "https://cdn-api.co-vin.in/api/v2/registration/certificate/public/download?beneficiary_reference_id=$(beneficiary_reference_id)"

function formatted_date(date::Date)
    dt = Dates.format(date, "dd-mm-yyyy")
    return dt
end