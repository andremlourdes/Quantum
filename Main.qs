import Microsoft.Quantum.Diagnostics.*;

operation Main() : Result {
    use q = Qubit();
    //Initialized qubit: Each qubit that is allocated with the use instruction starts in the state .
    // Therefore, DumpMachine outputs the information that corresponds to a single qubit register in the state .
    Message("Initialized qubit:");
    DumpMachine(); // First dump
    Message(" ");
    H(q);
    // Qubit after applying H: After applying H,
    // we prepare the qubit in the superposition state
    Message("Qubit after applying H:");
    DumpMachine(); // Second dump
    Message(" ");
    let randomBit = M(q);
    //Qubit after measurement: After we measure and store the result, which can be a Zero or a One. 
    //For example, if the resulting state is One, the state of the registers will be collapsed to 
    //and will no longer be in superposition.
    Message("Qubit after the measurement:");
    DumpMachine(); // Third dump
    Message(" ");
    Reset(q);
    //Qubit after reset: The Reset operation resets the qubit to the state .
    // Remember that in any Q# operation,
    // you always need to leave the used qubits in the state 
    //so that other operations can use it.
    Message("Qubit after resetting:");
    DumpMachine(); // Fourth dump
    Message(" ");
    return randomBit;
}