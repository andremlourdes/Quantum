operation QuantumTeleportation(source : Qubit, target : Qubit) : Unit {
    use entangledQubits = Qubit[2];
    
    H(entangledQubits[0]);
    CNOT(entangledQubits[0], entangledQubits[1]);

    CNOT(source, entangledQubits[0]);
    H(source);

    let m1 = M(source);
    let m2 = M(entangledQubits[0]);

    if (m2 == One) {
        X(target);
    }
    if (m1 == One) {
        Z(target);
    }
}
