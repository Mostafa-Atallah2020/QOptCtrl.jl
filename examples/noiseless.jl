using QOptCtrl

qctrl = NoiselessQCtrl(
        pauli_Z, # drift Hamiltonian
        [pauli_X, pauli_Y], # control Hamiltonians
        20, # number of steps
        4, # transfer time
        outer_prod(ket_0, ket_0), # initial density operator
        outer_prod(ket_1, ket_0) + outer_prod(ket_0, ket_1), # target density operator
        0.95, #minimum fidelity
        rand(20, 2) #initial guess
)

init_ctrl_arr,  final_ctrl_arr = GRAPE(qctrl, noise=false)
visualise_pulses(init_ctrl_arr, final_ctrl_arr)
