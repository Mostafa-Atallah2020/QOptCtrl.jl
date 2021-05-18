function performance_func(prob, ctrl_amps, timeslices)
    λ = back_target_op(prob, ctrl_amps, timeslices)
    ρ = density_op(prob, ctrl_amps, timeslices)
    return expval(λ, ρ)
end

function C1_cost(init_unitary, tar_unitary, dim)
        return 1 - abs2(tr(tar_unitary'*init_unitary)/dim)
end

function C2_cost(init_state, final_state)
        return 1 - abs2(final_state'*init_state)
end

function density_op_fid(prob, ctrl_amps, init_density_op, target_density_op)
        ρt = density_op(prob, ctrl_amps, prob.n_steps)
        return expval(target_density_op, ρt)
end

function gate_infid(drift_Ham, ctrl_Hams, n_steps, transfer_time, ctrl_amps, tar_gate)
    KT = tar_gate
    KN = evolve(drift_Ham, ctrl_Hams, n_steps, transfer_time, ctrl_amps, n_steps)
    D = size(drift_Ham)[1]
    return 1 - abs2(tr(KT'*KN)/D)
end

function state_infid(drift_Ham, ctrl_Hams, n_steps, transfer_time, ctrl_amps, init_state, tar_state)
    ψT = tar_state
    ψN = evolve(drift_Ham, ctrl_Hams, n_steps, transfer_time, ctrl_amps, n_steps)*init_state
    return 1 - abs2(ψT'ψN)
end
