function performance_func(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices,
                          init_density_op, target_density_op)
    λ = back_target_op(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices, target_density_op)
    ρ = density_op(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices, init_density_op)
    return expval(λ, ρ)
end
