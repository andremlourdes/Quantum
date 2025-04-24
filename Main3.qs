//There are three concepts here:
//The variable qubits now represents a qubit array that has a length of three.
//The ApplyToEach and ForEach operations are useful for measuring and acting on multiple qubits while using less code. 
//The Q# libraries provide many types of operations and functions that make writing quantum programs more efficient.
//The BoolArrayAsInt and ResultArrayAsBoolArray functions from the Microsoft.Quantum.
//Convert library transform the binary array Result that is returned by ForEach(M, qubits) into an integer.
//To run the program, select Run above the Main operation or press Ctrl+F5. The output will be displayed in the debug console.
//When you use DumpMachine, you will see how the act of measuring the three qubits collapses the state of
// the register into one of eight possible basis states. For example,
// if you get the result 3, that means the state of the register has collapsed to |110>.
//The ForEach(M, qubit) operation measures one qubit at a time, gradually collecting the state. 
//You can also dump the intermediate states after each measurement.
//Here, you use a for loop to act on each qubit sequentially. Q# has classic flow control features, such as for loops and if statements,
// that you can use to control the flow of your program.
//To run the program, select Run from the list of commands above the Main operation or press Ctrl+F5.
//You can see how each consecutive measurement changes the quantum state and therefore the probabilities of obtaining each outcome.
// For example, if the outcome is the number five, you will get the following output. Let's quickly go through each step:
//Preparing the state: After applying H to each qubit in the register, we obtain a uniform superposition.
//First measurement: in this one, the result was One. 
//Therefore, all the amplitudes of the states whose rightmost qubit is Zero are no longer present. 
//The amplitudes are |0>,|100>,|2>,|110>,|4>,|100 and 6 |6>,||110> and The other amplitudes increase to meet the normalization condition.
//Second measurement: in this measurement, the result was Zero. Therefore, all the amplitudes of the states whose second rightmost (middle) qubit is One disappear.
// The amplitudes are |3>, |011> and |7>,|111> and The other amplitudes increase to meet the normalization condition.
//Third measurement: in this one, the result was One. Therefore, all the amplitudes of the states whose leftmost qubit is Zero are cleared.
// The only compatible state is |5>,|101> and This state obtains an amplitude probability of 1 .

import Microsoft.Quantum.Diagnostics.*;
import Microsoft.Quantum.Measurement.*;
import Microsoft.Quantum.Math.*;
import Microsoft.Quantum.Convert.*;

operation Main() : Int {
    use qubits = Qubit[3];
    ApplyToEach(H, qubits);
    Message("The qubit register in a uniform superposition: ");
    DumpMachine();
    mutable results = [];
    for q in qubits {
        Message(" ");
        set results += [M(q)];
        DumpMachine();
    }
    Message(" ");
    Message("Your random number is: ");
    ResetAll(qubits);
    return BoolArrayAsInt(ResultArrayAsBoolArray(results));
}