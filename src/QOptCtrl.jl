module QOptCtrl

include("basic_funcs.jl")
include("propagator.jl")

export pauli_I, pauli_X, pauli_Y, pauli_Z, ket_0, ket_1
export evolve, evolve_back


end # module
