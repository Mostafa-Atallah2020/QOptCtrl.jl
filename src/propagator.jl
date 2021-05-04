function evolve(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices)
    Δt = transfer_time/n_steps
    U = Matrix(I, size(drift_Ham))
    n_pulses = length(ctrl_Hams)

    for i = 1:timeslices
        H_tot = drift_Ham

        for k = 1:n_pulses
            H_tot = H_tot + ctrl_amps[i, k]*ctrl_Hams[k]
        end
        U = exp(-1.0im * Δt * H_tot) * U
    end
    U
end

function evolve_back(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices)
    U = Matrix(I, size(drift_Ham))
    n_pulses = length(ctrl_Hams)

    for timeslice in transfer_time:-1:timeslices+1
        U = evolve(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslice)' * U
    end
    U
end

function density_op(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices, init_density_op)
    evo = evolve(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices)
    return evo*init_density_op*evo'
end

function back_target_op(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices, target_density_op)
    back_evo = evolve_back(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices)
    return back_evo*target_density_op*back_evo'
end
