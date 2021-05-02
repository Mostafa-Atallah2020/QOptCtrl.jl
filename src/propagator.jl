function evolve(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices, U0)
    Δt = transfer_time/n_steps
    U = U0
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

function evolve_back(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices, U0)
    Δt = transfer_time/n_steps
    U = U0
    n_pulses = length(ctrl_Hams)

    for i = reverse(timeslices+1:transfer_time)
        H_tot = drift_Ham

        for k = 1:n_pulses
            H_tot = H_tot + ctrl_amps[i, k]*ctrl_Hams[k]
        end
        U = exp(1.0im * Δt * H_tot) * U
    end
    U
end
