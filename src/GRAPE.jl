function init_ctrl_amps(ctrl_Hams, n_steps)
        return rand(n_steps, length(ctrl_Hams))
end

function Basic_GRAPE(drift_Ham, ctrl_Hams, n_steps, transfer_time, init_density_op, target_density_op, min_fid, init_guess)
        ctrl_amps = init_guess
        init_guess_amps = copy(ctrl_amps)
        n_ctrl_Hams = length(ctrl_Hams)
        Δt = transfer_time/n_steps
        count = 0

        for ctrl_Ham in 1:n_ctrl_Hams
                for timeslice in 1:n_steps
                        λ = back_target_op(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslice, target_density_op)
                        ρ = density_op(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslice, init_density_op)
                        cost = performance_func(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslice, init_density_op, target_density_op)
                        if cost > min_fid
                                println("solution converged at step = ", ctrl_Ham*timeslice)
                                @goto esc
                        end
                        A = λ
                        B = -1im * Δt * commutator(ctrl_Hams[ctrl_Ham], ρ)
                        ctrl_amps[timeslice, ctrl_Ham] = ctrl_amps[timeslice, ctrl_Ham] + expval(A,B)
                end
        end
        println("solution couldn't be found try another parameters")
        @label esc
        return init_guess_amps, ctrl_amps
end

function GRAPE(prob; noise=false)
        if noise
                # to be added ....
        else
                init_guess_amps, ctrl_amps = Basic_GRAPE(prob.drift_Ham, prob.ctrl_Hams, prob.n_steps, prob.transfer_time, prob.init_density_op, prob.target_density_op, prob.min_fid, prob.init_guess)
                return init_guess_amps, ctrl_amps
        end
end
