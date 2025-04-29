namespace Quantum.Grover {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Diagnostics;

    operation RunGroverSearch() : Result[] {
        // Número de iterações ótimas para 2 qubits (2^2 = 4 itens)
        let iterations = 1;
        let nQubits = 2;
        
        // Alocar registros quânticos
        use (qubits, oracleQubit) = (Qubit[nQubits], Qubit());
        
        // Inicializar estado uniforme
        ApplyToEachA(H, qubits);
        
        // Executar iterações de Grover
        for _ in 1..iterations {
            // Aplicar o oráculo (marca o estado |11> como solução)
            Oracle_11(qubits, oracleQubit);
            
            // Aplicar a difusão de Grover
            GroverDiffusion(qubits);
        }
        
        // Medir o resultado
        let result = MeasureEachZ(qubits);
        
        // Resetar qubits
        ResetAll(qubits);
        Reset(oracleQubit);
        
        return result;
    }

    // Oráculo que marca o estado |11> como solução
    operation Oracle_11(qubits : Qubit[], oracleQubit : Qubit) : Unit is Adj + Ctl {
        within {
            // Preparar o oracle qubit no estado |->
            X(oracleQubit);
            H(oracleQubit);
        } apply {
            // Aplicar CCCZ (marca |11> com fase negativa)
            Controlled Z([qubits[0], qubits[1]], oracleQubit);
        }
    }

    // Operação de difusão de Grover
    operation GroverDiffusion(qubits : Qubit[]) : Unit is Adj + Ctl {
        within {
            // Transformar para a base computacional
            ApplyToEachA(H, qubits);
            ApplyToEachA(X, qubits);
        } apply {
            // Aplicar Z controlado por todos os qubits
            Controlled Z(Most(qubits), Tail(qubits));
        } apply {
            // Transformar de volta para a base de Hadamard
            ApplyToEachA(X, qubits);
            ApplyToEachA(H, qubits);
        }
    }

    // Operação de teste
    operation TestGroverSearch() : String {
        mutable results = new Result[0];
        let count = 100;
        
        for _ in 1..count {
            set results += [RunGroverSearch()];
        }
        
        // Contar ocorrências de |11>
        let successCount = ResultArrayAsInt(results, 2) 
                          |> ArrayFilter(x -> x == 3) 
                          |> Length;
        
        return $"Encontrado |11> em {successCount} de {count} tentativas (esperado ~75%)";
    }
}