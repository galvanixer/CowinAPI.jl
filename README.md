# CowinAPI

[![Build Status](https://travis-ci.com/galvanixer/CowinAPI.jl.svg?branch=master)](https://travis-ci.com/galvanixer/CowinAPI.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/galvanixer/CowinAPI.jl?svg=true)](https://ci.appveyor.com/project/galvanixer/CowinAPI-jl)
[![Codecov](https://codecov.io/gh/galvanixer/CowinAPI.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/galvanixer/CowinAPI.jl)
[![Coveralls](https://coveralls.io/repos/github/galvanixer/CowinAPI.jl/badge.svg?branch=master)](https://coveralls.io/github/galvanixer/CowinAPI.jl?branch=master)

This package is a Julia wrapper over Co-WIN Public APIs. This package provides the functionality to find appointment availability using Co-WIN Public API. 





The package is limited by the latency rates of the Co-WIN API. The limitations are as follows:

1. Appointment availability data is cached and may be upto 30 minutes late.
2. These APIs are subject to a rate limit of 100 API calls per 5 minutes per IP. 