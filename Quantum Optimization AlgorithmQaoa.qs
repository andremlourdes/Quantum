namespace QAOA {
    open Microsoft.Quantum.Arrays;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    
    operation CostHamiltonian(qs : Qubit[], gamma : Double) : Unit {
        // Implements the cost Hamiltonian for a specific problem
       // Example: MAX-CUT problem
        for (i in 0..Length(qs)-1) {
            for (j in i+1..Length(qs)-1) {
                if (ProblemGraphHasEdge(i, j)) { // // Function that defines the problem graph
                    CNOT(qs[i], qs[j]);
                    Rz(2.0 * gamma, qs[j]);
                    CNOT(qs[i], qs[j]);
                }
            }
        }
    }
    
    operation MixerHamiltonian(qs : Qubit[], beta : Double) : Unit {
        // Implements the mixing Hamiltonian
        ApplyToEach(Rx(2.0 * beta, _), qs);
    }
    
    operation RunQAOA(nLayers : Int, angles : (Double[], Double[])) : Double {
       // nLayers: number of QAOA layers 
      // angles: tuple of arrays (gammas, betas) for each layer
        
        use qs = Qubit[ProblemSize()]; // ProblemSize() retorna o número de qubits necessário
        
        // Initial state
        ApplyToEach(H, qs);
        
        // Apply QAOA layers
        for (layer in 0..nLayers-1) {
            CostHamiltonian(qs, angles::0[layer]);
            MixerHamiltonian(qs, angles::1[layer]);
        }
        
        // Measurement and calculation of expected value
        let expectation = EstimateExpectation(qs); // Function that estimates the expected value
        ResetAll(qs);
        return expectation;
    }
}