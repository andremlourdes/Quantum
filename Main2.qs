import Microsoft.Quantum.Diagnostics.*;
import Microsoft.Quantum.Math.*;

//This example chooses to be about 1/3
//This example uses the inverse cosine function to calculate the angle of rotation
//The inverse cosine function is used to calculate the angle of rotation for the qubit
//The angle of rotation is used to create a superposition of the qubit state
//DumpMachine displays the expected state after applying the operations and shows the associated probabilities.
// Note that the probability of getting Zero is about 33.33%, and the probability of getting One is about 66.67%.
// Thus, the random bit generator is distorted.

operation Main() : Result {
    use q = Qubit();
    let P = 0.333333; // P is 1/3
    Ry(2.0 * ArcCos(Sqrt(P)), q);
    Message("The qubit is in the desired state.");
    Message("");
    DumpMachine(); // Dump the state of the qubit 
    Message("");
    Message("Your skewed random bit is:");
    let skewedrandomBit = M(q);
    Reset(q);
    return skewedrandomBit;
}