

ket_0 = [1;0]
ket_1 = [0;1]

pauli_I = [1 0;0 1]
pauli_X = [0 1;1 0]
pauli_Y = [0 -1im;1im 0]
pauli_Z = [1 0;0 -1]

function commutator(mat1, mat2)
    mat1 * mat2 - mat2 * mat1
end

function expval(mat1, mat2)
    real(tr(mat1'*mat2))
end

function outer_prod(mat1, mat2)
    mat1*mat2'
end

function tr_norm(mat)
    real(tr(sqrt(mat*mat')))
end
