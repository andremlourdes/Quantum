using Microsoft.Quantum.Simulation.Simulators;
using System;

namespace Quantum.Grover {
    class Program {
        static void Main(string[] args) {
            using (var sim = new QuantumSimulator()) {
                var result = TestGroverSearch.Run(sim).Result;
                Console.WriteLine(result);
            }
        }
    }
}