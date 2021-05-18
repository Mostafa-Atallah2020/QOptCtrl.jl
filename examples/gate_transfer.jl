using QOptCtrl, LinearAlgebra, Optim

X = pauli_X
Y = pauli_Y
Z = pauli_Z
H = 1/sqrt(2)*[1 1; 1 -1] # Hadamard Gate

prob = GateTransfer(
        0.25*Z, # drift Hamiltonian
        [X, Y], # control Hamiltonians
        20, # number of steps
        4, # transfer time
        H, # tarfet gate
        rand(20, 2) #initial guess
)

init_ctrl_arr,  final_ctrl_arr = AUTO_DIFF(prob)
visualise_pulses(init_ctrl_arr, final_ctrl_arr)
