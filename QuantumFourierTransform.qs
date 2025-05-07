import Microsoft.Quantum.Diagnostics.*;
import Microsoft.Quantum.Math.*;
import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Arrays.*;



operation QuantumFourierTransform(qubits : Qubit[]) : Unit is Adj + Ctl {
    for i in 0..Length(qubits) - 1 {
        H(qubits[i]);
        for j in i + 1..Length(qubits) - 1 {
            let angle = 1.0 / (1 <<< (j - i));
            Controlled R1([qubits[j]])(angle * PI, qubits[i]);
        }
    }

    ApplyReverse(qubits);
}
