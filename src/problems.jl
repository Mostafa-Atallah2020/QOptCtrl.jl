struct NoiselessQCtrl
        drift_Ham
        ctrl_Hams
        n_steps
        transfer_time
        init_density_op
        target_density_op
        init_guess
end

struct GateTransfer
    drift_Ham
    ctrl_Hams
    n_steps
    transfer_time
    tar_gate
    init_guess
end

struct StateTransfer
    drift_Ham
    ctrl_Hams
    n_steps
    transfer_time
    init_state
    tar_state
    init_guess
end

export GateTransfer, StateTransfer 
