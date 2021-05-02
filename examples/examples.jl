using QOptCtrl

drift_Ham = 0.1*pauli_Z
ctrl_Hams = [pauli_X, pauli_Y]
ctrl_amps = [1 1;
             1 1;
             1 1;
             1 1]
transfer_time = 4
n_steps = 4
timeslices = 3

U0 = pauli_I

evolve_back(drift_Ham, ctrl_Hams, ctrl_amps, n_steps, transfer_time, timeslices, U0)'
