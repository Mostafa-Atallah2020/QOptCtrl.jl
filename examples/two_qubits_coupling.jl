using QOptCtrl

I = pauli_I
X = pauli_X
Y = pauli_Y
Z = pauli_Z

J = 1

prob = StateTransfer(
    J*kron(Z, Z), # drift Hamiltonian
    [kron(X, I), kron(Y, I), kron(I, X), kron(I, Y)], # control Hamiltonians
    10, # number of steps
    4, # transfer time
    kron(ket_0, ket_0), # initial state |00>
    kron(ket_0, ket_1), # target state |01>
    rand(10, 4) #initial guess
)

init_ctrl_arr,  final_ctrl_arr = OPTIMIZE(prob)
visualise_pulses(init_ctrl_arr, final_ctrl_arr)
