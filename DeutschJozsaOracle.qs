operation DeutschJozsaOracle(qubits : Qubit[]) : Unit {
    for q in qubits {
        X(q);
        H(q);
    }

    // Simulação do oráculo
    CNOT(qubits[0], qubits[Length(qubits) - 1]);

    for q in qubits {
        H(q);
    }
}
