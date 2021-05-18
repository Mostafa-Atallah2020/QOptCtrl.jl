using QOptCtrl, LinearAlgebra, Optim

I = pauli_I
X = pauli_X
Y = pauli_Y
Z = pauli_Z

prob = StateTransfer(
    kron(Z, Z), # drift Hamiltonian
    [kron(X, I), kron(Y, I), kron(I, X), kron(I, Y)], # control Hamiltonians
    10, # number of steps
    4, # transfer time
    kron(ket_0, ket_0), # initial state |0> ⊗ |0>
    kron(ket_0, ket_1), # target state |0> ⊗ |1>
    rand(10, 4) #initial guess
)

init_ctrl_arr,  final_ctrl_arr = AUTO_DIFF(prob)
visualise_pulses(init_ctrl_arr, final_ctrl_arr)
