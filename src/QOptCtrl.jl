module QOptCtrl

using LinearAlgebra, Plots, Optim

include("basic_funcs.jl")
include("cost_funcs.jl")
include("optimization.jl")
include("propagator.jl")
include("visualization.jl")

export pauli_I, pauli_X, pauli_Y, pauli_Z, ket_0, ket_1, commutator, expval, outer_prod, tr_norm
export performance_func, C1_cost, C2_cost, density_op_fid, gate_infid, state_infid
export Basic_GRAPE, GRAPE, C1_grad, OPTIMIZE
export evolve, density_op, back_target_op, evolve_back
export visualise_pulses


end # module
