# CowinAPI

[![Build Status](https://travis-ci.com/galvanixer/CowinAPI.jl.svg?branch=master)](https://travis-ci.com/galvanixer/CowinAPI.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/galvanixer/CowinAPI.jl?svg=true)](https://ci.appveyor.com/project/galvanixer/CowinAPI-jl)
[![Codecov](https://codecov.io/gh/galvanixer/CowinAPI.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/galvanixer/CowinAPI.jl)
[![Coveralls](https://coveralls.io/repos/github/galvanixer/CowinAPI.jl/badge.svg?branch=master)](https://coveralls.io/github/galvanixer/CowinAPI.jl?branch=master)

This package is a Julia wrapper over Co-WIN Public APIs. This package provides the functionality to find appointment availability using Co-WIN Public API. 

## Installation

```julia 
pkg> add https://github.com/galvanixer/CowinAPI.jl.git
```

## Usage 

1. Generating list of states

```julia 
julia> using CowinAPI
julia> CowinAPI.get_states()
37×2 DataFrames.DataFrame
│ Row │ state_id │ state_name                  │
│     │ Int64    │ String                      │
├─────┼──────────┼─────────────────────────────┤
│ 1   │ 1        │ Andaman and Nicobar Islands │
│ 2   │ 2        │ Andhra Pradesh              │
│ 3   │ 3        │ Arunachal Pradesh           │
│ 4   │ 4        │ Assam                       │
│ 5   │ 5        │ Bihar                       │
│ 6   │ 6        │ Chandigarh                  │
│ 7   │ 7        │ Chhattisgarh                │
│ 8   │ 8        │ Dadra and Nagar Haveli      │

```

2. Getting a list of districts in a particular state 

```julia 
julia> CowinAPI.get_districts("Kerala")
14×2 DataFrames.DataFrame
│ Row │ district_id │ district_name      │
│     │ Int64       │ String             │
├─────┼─────────────┼────────────────────┤
│ 1   │ 301         │ Alappuzha          │
│ 2   │ 307         │ Ernakulam          │
│ 3   │ 306         │ Idukki             │
│ 4   │ 297         │ Kannur             │
│ 5   │ 295         │ Kasaragod          │
│ 6   │ 298         │ Kollam             │
│ 7   │ 304         │ Kottayam           │
│ 8   │ 305         │ Kozhikode          │
│ 9   │ 302         │ Malappuram         │
│ 10  │ 308         │ Palakkad           │
│ 11  │ 300         │ Pathanamthitta     │
│ 12  │ 296         │ Thiruvananthapuram │
│ 13  │ 303         │ Thrissur           │
│ 14  │ 299         │ Wayanad            │
```

3. Get district ID
```julia
julia> CowinAPI.get_district_id("Kerala","Wayanad")
299
```

4. Get vaccination sessions by PIN code

```julia
julia> CowinAPI.find_by_pin(585201, "11-05-2021")
4×19 DataFrames.DataFrame. Omitted printing of 12 columns
│ Row │ block_name │ lat     │ long    │ center_id │ state_name │ min_age_limit │ pin    │
│     │ String     │ Float64 │ Float64 │ Int64     │ String     │ Int64         │ Int64  │
├─────┼────────────┼─────────┼─────────┼───────────┼────────────┼───────────────┼────────┤
│ 1   │ Shorapur   │ 0.0     │ 0.0     │ 687212    │ Karnataka  │ 45            │ 585201 │
│ 2   │ Yadgir     │ 0.0     │ 0.0     │ 660629    │ Karnataka  │ 45            │ 585201 │
│ 3   │ Yadgir     │ 16.0    │ 77.0    │ 685569    │ Karnataka  │ 45            │ 585201 │
│ 4   │ Yadgir     │ 0.0     │ 0.0     │ 686401    │ Karnataka  │ 45            │ 585201 │
```


5. Get vaccination sessions by district (district_id)
```julia
julia> CowinAPI.get_district_id("Karnataka", "Yadgir")
285

julia> CowinAPI.find_by_district(285, "13-05-2021")
265×19 DataFrames.DataFrame. Omitted printing of 12 columns
│ Row │ block_name │ lat     │ long    │ center_id │ state_name │ min_age_limit │ pin    │
│     │ String     │ Float64 │ Float64 │ Int64     │ String     │ Int64         │ Int64  │
├─────┼────────────┼─────────┼─────────┼───────────┼────────────┼───────────────┼────────┤
│ 1   │ Shorapur   │ 16.0    │ 76.0    │ 688777    │ Karnataka  │ 45            │ 585224 │
│ 2   │ Yadgir     │ 16.0    │ 77.0    │ 685607    │ Karnataka  │ 45            │ 585321 │
│ 3   │ Shorapur   │ 16.0    │ 76.0    │ 688796    │ Karnataka  │ 45            │ 585224 │
│ 4   │ Shorapur   │ 16.0    │ 76.0    │ 564521    │ Karnataka  │ 45            │ 585215 │
│ 5   │ Shorapur   │ 0.0     │ 0.0     │ 685533    │ Karnataka  │ 45            │ 585220 │
│ 6   │ Shorapur   │ 16.0    │ 76.0    │ 688759    │ Karnataka  │ 45            │ 585215 │
│ 7   │ Yadgir     │ 0.0     │ 0.0     │ 643886    │ Karnataka  │ 45            │ 585202 │
│ 8   │ Yadgir     │ 16.0    │ 77.0    │ 685644    │ Karnataka  │ 45            │ 585202 │
│ 9   │ Yadgir     │ 0.0     │ 0.0     │ 686344    │ Karnataka  │ 45            │ 585202 │
│ 10  │ Shahapur   │ 0.0     │ 0.0     │ 686541    │ Karnataka  │ 45            │ 585309 │
```

6. Get vaccination sessions by PIN for 7 days
```julia
julia> CowinAPI.calendar_by_pin(585201, "13-05-2021")
45×18 DataFrames.DataFrame. Omitted printing of 11 columns
│ Row │ block_name │ date       │ available_capacity │ vaccine    │ lat     │ long    │ center_id │
│     │ String     │ String     │ Float64            │ String     │ Float64 │ Float64 │ Int64     │
├─────┼────────────┼────────────┼────────────────────┼────────────┼─────────┼─────────┼───────────┤
│ 1   │ Yadgir     │ 13-05-2021 │ 50.0               │ COVISHIELD │ 16.0    │ 77.0    │ 685569    │
│ 2   │ Yadgir     │ 14-05-2021 │ 50.0               │ COVISHIELD │ 16.0    │ 77.0    │ 685569    │
│ 3   │ Yadgir     │ 15-05-2021 │ 50.0               │ COVISHIELD │ 16.0    │ 77.0    │ 685569    │
│ 4   │ Yadgir     │ 16-05-2021 │ 50.0               │ COVISHIELD │ 16.0    │ 77.0    │ 685569    │
│ 5   │ Yadgir     │ 17-05-2021 │ 49.0               │ COVISHIELD │ 16.0    │ 77.0    │ 685569    │
│ 6   │ Yadgir     │ 18-05-2021 │ 50.0               │ COVISHIELD │ 16.0    │ 77.0    │ 685569    │
│ 7   │ Yadgir     │ 19-05-2021 │ 50.0               │ COVISHIELD │ 16.0    │ 77.0    │ 685569    │
│ 8   │ Yadgir     │ 13-05-2021 │ 50.0               │ COVISHIELD │ 0.0     │ 0.0     │ 686401    │
│ 9   │ Yadgir     │ 14-05-2021 │ 50.0               │ COVISHIELD │ 0.0     │ 0.0     │ 686401    │
│ 10  │ Yadgir     │ 15-05-2021 │ 50.0               │ COVISHIELD │ 0.0     │ 0.0     │ 686401    │
```

7. Get vaccination sessions by district for 7 days
```julia
julia> CowinAPI.calendar_by_district(285, "13-05-2021")
2114×18 DataFrames.DataFrame. Omitted printing of 11 columns
│ Row  │ block_name │ date       │ available_capacity │ vaccine    │ lat     │ long    │ center_id │
│      │ String     │ String     │ Float64            │ String     │ Float64 │ Float64 │ Int64     │
├──────┼────────────┼────────────┼────────────────────┼────────────┼─────────┼─────────┼───────────┤
│ 1    │ Shahapur   │ 13-05-2021 │ 0.0                │ COVISHIELD │ 16.0    │ 76.0    │ 660580    │
│ 2    │ Shahapur   │ 14-05-2021 │ 0.0                │ COVISHIELD │ 16.0    │ 76.0    │ 660580    │
│ 3    │ Shahapur   │ 15-05-2021 │ 0.0                │ COVISHIELD │ 16.0    │ 76.0    │ 660580    │
│ 4    │ Shahapur   │ 16-05-2021 │ 0.0                │ COVISHIELD │ 16.0    │ 76.0    │ 660580    │
│ 5    │ Shahapur   │ 17-05-2021 │ 0.0                │ COVISHIELD │ 16.0    │ 76.0    │ 660580    │
│ 6    │ Shahapur   │ 18-05-2021 │ 0.0                │ COVISHIELD │ 16.0    │ 76.0    │ 660580    │
│ 7    │ Shahapur   │ 19-05-2021 │ 0.0                │ COVISHIELD │ 16.0    │ 76.0    │ 660580    │
│ 8    │ Shorapur   │ 13-05-2021 │ 50.0               │ COVAXIN    │ 16.0    │ 76.0    │ 688777    │
│ 9    │ Shorapur   │ 14-05-2021 │ 50.0               │ COVAXIN    │ 16.0    │ 76.0    │ 688777    │
│ 10   │ Shorapur   │ 15-05-2021 │ 50.0               │ COVAXIN    │ 16.0    │ 76.0    │ 688777    │
```



**TO DO:** 

1. Register package at Julia registry
2. Write unit tests and enable code coverage

**NOTE:** 

The package is limited by the latency rates of the Co-WIN API. The limitations are as follows:

1. Appointment availability data is cached and may be upto 30 minutes late.
2. These APIs are subject to a rate limit of 100 API calls per 5 minutes per IP. 