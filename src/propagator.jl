#=
function evolve(prob, ctrl_amps, timeslices)
    Δt = prob.transfer_time/prob.n_steps
    U = Matrix(I, size(prob.drift_Ham))
    n_pulses = length(prob.ctrl_Hams)

    for i = 1:timeslices
        H_tot = prob.drift_Ham

        for k = 1:n_pulses
            H_tot = H_tot + ctrl_amps[i, k]*prob.ctrl_Hams[k]
        end
        U = exp(-1.0im * Δt * H_tot) * U
    end
    U
end
=#

function evolve(drift_Ham, ctrl_Hams, n_steps, transfer_time, ctrl_amps, timeslices)
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

function evolve_back(prob, ctrl_amps, timeslices)
    U = Matrix(I, size(prob.drift_Ham))
    n_pulses = length(prob.ctrl_Hams)

    for timeslice in prob.transfer_time:-1:timeslices+1
        U = evolve(prob, ctrl_amps, timeslices)' * U
    end
    U
end

function density_op(prob, ctrl_amps, timeslices)
    evo = evolve(prob, ctrl_amps, timeslices)
    return evo*prob.init_density_op*evo'
end

function back_target_op(prob, ctrl_amps, timeslices)
    back_evo = evolve_back(prob, ctrl_amps, timeslices)
    return back_evo*prob.target_density_op*back_evo'
end
