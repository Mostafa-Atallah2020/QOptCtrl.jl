# QOptCtrl.jl

*A general package on Quantum Optimal Control for [Julia][julia].*

<!--written as raw html to avoid including these in the generated PDFs-->
<a href=""><img src="https://img.shields.io/badge/docs-0.1.0-blue.svg" alt="Documentation (stable)" /></a>
<a href=""><img src="https://img.shields.io/badge/docs-dev-blue.svg" alt="Documentation (dev)" /></a>
<!--<img src="https://github.com/workflows/CI/badge.svg" alt="Build Status" /> -->
<a href=""><img src="https://codecov.io/gh/branch/master/graph/badge.svg" alt="codecov" /></a>


> **Disclaimer**
>
> Currently this package should be regarded as experimental --- a proving
> ground for new features for the Julia documentation ecosystem rather than
> a mature and proven piece of software.


This project aims at developing a general purpose library for implementing gates in the presence of noise or other physical/hardware restrictions.
A few examples are engineering an arbitrary single qubit gate in the presence of stochastic fluctuation in frequency parameters. Another example is engineering a pulse sequence to effectively decoupe a system of interacting spins. Or, designing an optimum pulse sequence to rotate an ensemble of electrons in the presence of an inhomogeneous magnetic field.


To jump straight in and begin using `QOptCtrl` run the following in your Julia REPL:

```julia-repl
pkg> add Package

julia> using Package
```

[Julia]: https://www.julialang.org
[pkg.jl]: https://julialang.github.io/Pkg.jl
