import Microsoft.Quantum.Diagnostics.*;
import Microsoft.Quantum.Math.*;
import Microsoft.Quantum.Convert.*;
import Microsoft.Quantum.Arrays.*;


//three concepts:

//The variable qubits now represents a qubit array that has a length of three.
//The ApplyToEach and ForEach operations are useful for measuring and acting on multiple qubits
// and use less code. The Q# libraries provide many types of operations and functions that make writing quantum programs more efficient.
//The BoolArrayAsInt and ResultArrayAsBoolArray functions from the Microsoft.Quantum.
//Convert library transform the binary array Result that is returned by ForEach(M, qubits) into an integer.


operation Main() : Int {
    use qubits = Qubit[3];
    ApplyToEach(H, qubits);
    Message("The qubit register in a uniform superposition: ");
    DumpMachine();
    let result = ForEach(M, qubits);
    Message("Measuring the qubits collapses the superposition to a basis state.");
    DumpMachine();
    ResetAll(qubits);
    return BoolArrayAsInt(ResultArrayAsBoolArray(result));
}