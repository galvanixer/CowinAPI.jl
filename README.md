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

3. ```julia 
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

4. 

   



The package is limited by the latency rates of the Co-WIN API. The limitations are as follows:

1. Appointment availability data is cached and may be upto 30 minutes late.
2. These APIs are subject to a rate limit of 100 API calls per 5 minutes per IP. 