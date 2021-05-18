include("problems.jl")

function Basic_GRAPE(prob)
        ctrl_amps = prob.init_guess
        init_guess_amps = copy(ctrl_amps)
        n_ctrl_Hams = length(prob.ctrl_Hams)
        Δt = prob.transfer_time/prob.n_steps

        for ctrl_Ham in 1:n_ctrl_Hams
                for timeslice in 1:prob.n_steps
                        λ = back_target_op(prob, ctrl_amps, timeslice)
                        ρ = density_op(prob, ctrl_amps, timeslice)
                        thre = 1 - performance_func(prob, ctrl_amps, timeslice)
                        if thre < 1 - prob.min_fid
                                println("solution converged at step = ", ctrl_Ham*timeslice)
                                @goto esc
                        end
                        A = λ
                        B = -1im * Δt * commutator(prob.ctrl_Hams[ctrl_Ham], ρ)
                        ctrl_amps[timeslice, ctrl_Ham] = ctrl_amps[timeslice, ctrl_Ham] - expval(A,B)
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
                init_guess_amps, ctrl_amps = Basic_GRAPE(prob)
                return init_guess_amps, ctrl_amps
        end
end

function C1_grad(prob, ctrl_amps)
        grad = Array{Float64}(undef, prob.n_steps, length(prob.ctrl_Hams))
        P = tr(prob.target_density_op'*prob.init_density_op)*prob.target_density_op'
        X = prob.init_density_op
        Δt = prob.transfer_time/prob.n_steps
        for j in reverse(1:prob.n_steps)
                for k in 1:length(prob.ctrl_Hams)
                        grad[j,k] = 2*Δt*tr(P*prob.ctrl_Hams[k]*X)
                end
                X = evolve(prob, ctrl_amps, j)'*X
                P = P*evolve(prob, ctrl_amps, j)
        end
        return grad
end

function GRAPE_auto_diff(prob)
        grad = Array{Float64}(undef, prob.n_steps, length(prob.ctrl_Hams))
        P = tr(prob.target_density_op'*prob.init_density_op)*prob.target_density_op'
        X = prob.init_density_op
        Δt = prob.transfer_time/prob.n_steps

        ctrl_amps = prob.init_guess
        init_guess_amps = copy(ctrl_amps)

        infid = C1_cost(X, prob.target_density_op, 2)

        while infid > 1
                println(infid)
                for j in reverse(1:prob.n_steps)
                        for k in 1:length(prob.ctrl_Hams)
                                grad[j,k] = 2*Δt*tr(P*prob.ctrl_Hams[k]*X)
                                ctrl_amps[j,k] = ctrl_amps[j,k] + 3*grad[j,k]
                        end
                        X = evolve(prob, ctrl_amps, j)'*X
                        P = P*evolve(prob, ctrl_amps, j)
                end
                infid = C1_cost(X, prob.target_density_op, 2)
        end
        #return ctrl_amps
end

#=
function AUTO_DIFF(prob)
        cost(u) = 1 - density_op_fid(prob, u, prob.init_density_op, prob.target_density_op)
        init_ctrl_arr = prob.init_guess

        res = optimize(cost, init_ctrl_arr)
        final_ctrl_arr = Optim.minimizer(res)

        return init_ctrl_arr, final_ctrl_arr
end
=#

function AUTO_DIFF(prob::GateTransfer)
    cost(u) = gate_infid(prob.drift_Ham, prob.ctrl_Hams, prob.n_steps, prob.transfer_time, u, prob.tar_gate)
    init_ctrl_arr = prob.init_guess

    res = optimize(cost, init_ctrl_arr)
    final_ctrl_arr = Optim.minimizer(res)
    fid = 1 - Optim.minimum(res)
    println("Fidelity = ", fid)
    return init_ctrl_arr, final_ctrl_arr
end

function AUTO_DIFF(prob::StateTransfer)
    cost(u) = state_infid(prob.drift_Ham, prob.ctrl_Hams, prob.n_steps, prob.transfer_time, u, prob.init_state, prob.tar_state)
    init_ctrl_arr = prob.init_guess

    res = optimize(cost, init_ctrl_arr)
    final_ctrl_arr = Optim.minimizer(res)
    fid = 1 - Optim.minimum(res)
    println("Fidelity = ", fid)
    return init_ctrl_arr, final_ctrl_arr
end
