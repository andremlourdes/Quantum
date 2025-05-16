namespace QuantumPhaseEstimation {
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation QuantumPhaseEstimation(oracle : ((Qubit[]) => Unit is Adj + Ctl), precision : Int) : Double {
        // Aloca registros
        use target = Qubit();
        use register = Qubit[precision];
        
        // Inicialização
        X(target);
        ApplyToEach(H, register);
        
        // Aplica oráculos controlados
        for (idx in 0..precision-1) {
            let power = PowI(2, idx);
            for (_ in 1..power) {
                Controlled oracle([register[idx]], target);
            }
        }
        
        // Transformada inversa de Fourier quântica
        InverseQFT(register);
        
        // Medição e interpretação
        let result = MeasureInteger(LittleEndian(register));
        ResetAll(register);
        Reset(target);
        
        return IntAsDouble(result) / IntAsDouble(PowI(2, precision));
    }
    
    operation ExampleOracle(qs : Qubit[]) : Unit is Adj + Ctl {
        let theta = 0.25; // Fase que queremos estimar
        Rz(2.0 * PI() * theta, qs[0]);
    }
}