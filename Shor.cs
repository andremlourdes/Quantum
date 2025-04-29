using Microsoft.Quantum.Simulation.Simulators;
using System;

namespace Quantum.Shor
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var sim = new QuantumSimulator())
            {
                var result = TestShorAlgorithm.Run(sim).Result;
                Console.WriteLine($"Fatores encontrados: {result.Item1} e {result.Item2}");
            }
        }
    }
}