module QOptCtrl

using LinearAlgebra, Plots

include("basic_funcs.jl")
include("cost_funcs.jl")
include("GRAPE.jl")
include("problems.jl")
include("propagator.jl")
include("visualization.jl")

export pauli_I, pauli_X, pauli_Y, pauli_Z, ket_0, ket_1, commutator, expval, outer_prod, tr_norm
export performance_func
export init_ctrl_amps, Basic_GRAPE, GRAPE
export NoiselessQCtrl
export evolve, density_op, back_target_op, evolve_back
export visualise_pulses


end # module
