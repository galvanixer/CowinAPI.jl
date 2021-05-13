module CowinAPI
using HTTP, JSON
using DataFrames, CSV
using Dates
include("urls.jl")

function make_API_call(url::String)
    try
        response = HTTP.get(url)
        return String(response.body)
    catch e 
        #return "Error occurred: $(e)"
        return e
    end
end

function get_states()
    url = get_states_url()
    try 
        str = make_API_call(url)
        jobj = JSON.Parser.parse(str)
        datadict = jobj["states"]
        df = DataFrame(state_id=Int[], state_name=String[])
        nrows = size(datadict)[1]
        for i in 1:nrows 
            push!(df.state_id, datadict[i]["state_id"])
            push!(df.state_name, datadict[i]["state_name"])
        end 
        return df
    catch e 
        return e 
    end 
end 

function get_state_ids()
    states = []
    try 
        states = get_states()
        stateIDs = Dict{String,Int}()
        for istate in 1:size(states)[1]
            stateIDs[states[istate, :state_name]]=states[istate, :state_id]
        end 
        return stateIDs
    catch e 
        return e 
    end 
end 

stateID = get_state_ids()

function get_districts(state::String)
    state_id = stateID[state] 
    url = get_districts_url(state_id)
    try
        str = make_API_call(url)
        jobj = JSON.Parser.parse(str)
        datadict = jobj["districts"]
        df = DataFrame(district_id=Int[], district_name=String[])
        nrows = size(datadict)[1]
        for i in 1:nrows
            push!(df.district_id, datadict[i]["district_id"])
            push!(df.district_name, datadict[i]["district_name"])
        end 
        return df
    catch e 
        return e 
    end 
end

function get_district_id(state::String, district::String)
    try
        df = get_districts(state)

        return df[df[!,:district_name].==district,:district_id][1]
    catch e
        return e 
    end
end

function find_by_pin(pin::Int, date::String)
    url = find_by_pin_url(pin, date)
    try 
        str = make_API_call(url)
        jobj = JSON.Parser.parse(str)
        datadict = jobj["sessions"]
        nrows = size(datadict)[1]
        df = DataFrame(block_name=String[], lat=Float64[], long=Float64[], center_id=Int[],
                       state_name=String[], min_age_limit=Int[], pin=Int[], address=String[],name=String[], 
                       session_id=String[], fee_type=String[], date=String[], available_capacity=Int[], vaccine=String[],
                       fee=String[], district_name=String[], from=String[], to=String[], slots=Array{String,1}[])
        for i in 1:nrows 
            push!(df.block_name, datadict[i]["block_name"])
            push!(df.lat, datadict[i]["lat"])
            push!(df.long, datadict[i]["long"])
            push!(df.center_id, datadict[i]["center_id"])
            push!(df.state_name, datadict[i]["state_name"])
            push!(df.min_age_limit, datadict[i]["min_age_limit"])
            push!(df.pin, datadict[i]["pincode"])
            push!(df.address, datadict[i]["address"])
            push!(df.name, datadict[i]["name"])
            push!(df.session_id, datadict[i]["session_id"])
            push!(df.fee_type, datadict[i]["fee_type"])
            push!(df.date, datadict[i]["date"])
            push!(df.available_capacity, datadict[i]["available_capacity"])
            push!(df.vaccine, datadict[i]["vaccine"])
            push!(df.fee, datadict[i]["fee"])
            push!(df.district_name, datadict[i]["district_name"])
            push!(df.from, datadict[i]["from"])
            push!(df.to, datadict[i]["to"])
            push!(df.slots, Array{String,1}(datadict[i]["slots"]))
        end

        return df
    catch e
        return e 
    end        
end 

function find_by_district(district_id::Int, date::String)
    url = find_by_district_url(district_id, date)
    try 
        str = make_API_call(url)
        jobj = JSON.Parser.parse(str)
        datadict = jobj["sessions"]
        nrows = size(datadict)[1]
        df = DataFrame(block_name=String[], lat=Float64[], long=Float64[], center_id=Int[],
                       state_name=String[], min_age_limit=Int[], pin=Int[], address=String[],name=String[], 
                       session_id=String[], fee_type=String[], date=String[], available_capacity=Int[], vaccine=String[],
                       fee=String[], district_name=String[], from=String[], to=String[], slots=Array{String,1}[])
        for i in 1:nrows 
            push!(df.block_name, datadict[i]["block_name"])
            push!(df.lat, datadict[i]["lat"])
            push!(df.long, datadict[i]["long"])
            push!(df.center_id, datadict[i]["center_id"])
            push!(df.state_name, datadict[i]["state_name"])
            push!(df.min_age_limit, datadict[i]["min_age_limit"])
            push!(df.pin, datadict[i]["pincode"])
            push!(df.address, datadict[i]["address"])
            push!(df.name, datadict[i]["name"])
            push!(df.session_id, datadict[i]["session_id"])
            push!(df.fee_type, datadict[i]["fee_type"])
            push!(df.date, datadict[i]["date"])
            push!(df.available_capacity, datadict[i]["available_capacity"])
            push!(df.vaccine, datadict[i]["vaccine"])
            push!(df.fee, datadict[i]["fee"])
            push!(df.district_name, datadict[i]["district_name"])
            push!(df.from, datadict[i]["from"])
            push!(df.to, datadict[i]["to"])
            push!(df.slots, Array{String,1}(datadict[i]["slots"]))
        end
        return df
    catch e
        return e 
    end        
end

function calendar_by_pin(pin::Int, date::String)
    url = calendar_by_pin_url(pin, date)
    try 
        str = make_API_call(url)
        jobj = JSON.Parser.parse(str)
        datadict = jobj["centers"]
        df = DataFrame(block_name=String[], lat=Float64[], long=Float64[], center_id=Int[],
                       state_name=String[], pin=Int[], address=String[], name=String[], session_id=String[],
                       slots=Array{String,1}[], date=String[], available_capacity=Float64[], min_age_limit=Int[],
                       vaccine=String[], fee_type=String[], district_name=String[], to=String[], from=String[])

        nrows = size(datadict)[1]
        for i in 1:nrows 
            nsessions = size(datadict[i]["sessions"])[1]
            for isession in 1:nsessions 
                sessiondata = datadict[i]["sessions"][isession]
                push!(df.block_name, datadict[i]["block_name"])
                push!(df.lat, datadict[i]["lat"])
                push!(df.long, datadict[i]["long"])
                push!(df.center_id, datadict[i]["center_id"])
                push!(df.state_name, datadict[i]["state_name"])
                push!(df.pin, datadict[i]["pincode"])
                push!(df.address, datadict[i]["address"])
                push!(df.name, datadict[i]["name"])

                # sessiondata 
                push!(df.session_id, sessiondata["session_id"])
                push!(df.slots, Array{String,1}(sessiondata["slots"]))
                push!(df.date, sessiondata["date"])
                push!(df.available_capacity, sessiondata["available_capacity"])
                push!(df.min_age_limit, sessiondata["min_age_limit"])
                push!(df.vaccine, sessiondata["vaccine"])
                # sessiondata END 

                push!(df.fee_type, datadict[i]["fee_type"])
                push!(df.district_name, datadict[i]["district_name"])
                push!(df.from, datadict[i]["from"])
                push!(df.to, datadict[i]["to"])
            end 
        end
        return df
    catch e
        return e
    end
end 

function calendar_by_district(district_id::Int, date::String)
    url = calendar_by_district_url(district_id, date)
    try 
        str = make_API_call(url)
        jobj = JSON.Parser.parse(str)
        datadict = jobj["centers"]

        df = DataFrame(block_name=String[], lat=Float64[], long=Float64[], center_id=Int[],
                       state_name=String[], pin=Int[], address=String[], name=String[], session_id=String[],
                       slots=Array{String,1}[], date=String[], available_capacity=Float64[], min_age_limit=Int[],
                       vaccine=String[], fee_type=String[], district_name=String[], to=String[], from=String[])
                       nrows = size(datadict)[1]
        for i in 1:nrows 
            nsessions = size(datadict[i]["sessions"])[1]
            for isession in 1:nsessions 
                sessiondata = datadict[i]["sessions"][isession]
                push!(df.block_name, datadict[i]["block_name"])
                push!(df.lat, datadict[i]["lat"])
                push!(df.long, datadict[i]["long"])
                push!(df.center_id, datadict[i]["center_id"])
                push!(df.state_name, datadict[i]["state_name"])
                push!(df.pin, datadict[i]["pincode"])
                push!(df.address, datadict[i]["address"])
                push!(df.name, datadict[i]["name"])

                # sessiondata 
                push!(df.session_id, sessiondata["session_id"])
                push!(df.slots, Array{String,1}(sessiondata["slots"]))
                push!(df.date, sessiondata["date"])
                push!(df.available_capacity, sessiondata["available_capacity"])
                push!(df.min_age_limit, sessiondata["min_age_limit"])
                push!(df.vaccine, sessiondata["vaccine"])
                # sessiondata END 

                push!(df.fee_type, datadict[i]["fee_type"])
                push!(df.district_name, datadict[i]["district_name"])
                push!(df.from, datadict[i]["from"])
                push!(df.to, datadict[i]["to"])
            end 
        end
        return df
    catch e
        return e
    end
end

function calendar_by_district_brief(district_id::Int, date::String)
    url = calendar_by_district_url(district_id, date)
    try 
        str = make_API_call(url)
        jobj = JSON.Parser.parse(str)
        datadict = jobj["centers"]

        df = DataFrame(center_id=Int[],
                       state_name=String[], pin=Int[], name=String[],
                       date=String[], available_capacity=Float64[], min_age_limit=Int[],
                       vaccine=String[], district_name=String[])
                       nrows = size(datadict)[1]
        for i in 1:nrows 
            nsessions = size(datadict[i]["sessions"])[1]
            for isession in 1:nsessions 
                sessiondata = datadict[i]["sessions"][isession]
                push!(df.center_id, datadict[i]["center_id"])
                push!(df.state_name, datadict[i]["state_name"])
                push!(df.pin, datadict[i]["pincode"])
                push!(df.name, datadict[i]["name"])

                # sessiondata 
                push!(df.date, sessiondata["date"])
                push!(df.available_capacity, sessiondata["available_capacity"])
                push!(df.min_age_limit, sessiondata["min_age_limit"])
                push!(df.vaccine, sessiondata["vaccine"])
                # sessiondata END 

                push!(df.district_name, datadict[i]["district_name"])
            end 
        end
        return df
    catch e
        return e
    end
end
# function download_certificate(beneficiary_reference_id::String)
#     url = download_certificate_url(beneficiary_reference_id)
#     return url 
# end

end # module
