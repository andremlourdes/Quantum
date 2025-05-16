namespace QuantumTeleportation {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Measurement;
    
    operation TeleportQuantumState(msgQubit : Qubit, targetQubit : Qubit) : Unit {
        use ancilla = Qubit();
        
        // Cria emaranhamento entre ancilla e target
        H(ancilla);
        CNOT(ancilla, targetQubit);
        
        // Protocolo de teleporte
        CNOT(msgQubit, ancilla);
        H(msgQubit);
        
        // Medição e correção
        let m1 = MResetZ(msgQubit);
        let m2 = MResetZ(ancilla);
        
        if (m1 == One) { Z(targetQubit); }
        if (m2 == One) { X(targetQubit); }
    }
    
    operation EntanglementSwapping(q1 : Qubit, q2 : Qubit, q3 : Qubit, q4 : Qubit) : Unit {
        // Cria emaranhamento entre q1-q2 e q3-q4
        H(q1);
        CNOT(q1, q2);
        H(q3);
        CNOT(q3, q4);
        
        // Medição de Bell em q2 e q3
        CNOT(q2, q3);
        H(q2);
        
        let m1 = M(q2);
        let m2 = M(q3);
        
        // Aplica correções em q1 e q4
        if (m1 == One) { Z(q1); }
        if (m2 == One) { X(q4); }
        
        // Agora q1 e q4 estão emaranhados
    }
}