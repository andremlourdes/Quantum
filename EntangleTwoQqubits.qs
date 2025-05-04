import Microsoft.Quantum.Diagnostics.*;
import Microsoft.Quantum.Math.*;
import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Arrays.*;

operation EntangleQubits() : Unit {
    use qubits = Qubit[2]; // Aloca dois qubits
    H(qubits[0]); // Aplica a porta Hadamard ao primeiro qubit
    CNOT(qubits[0], qubits[1]); // Aplica a porta CNOT com controle no primeiro qubit e alvo no segundo

    Message("The Entangle qubits.");
    DumpMachine(); // Mostra o estado quântico atual no console (apenas no simulador)
    
    ResetAll(qubits); // Reseta os qubits ao estado |0⟩
}
