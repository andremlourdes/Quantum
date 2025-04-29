namespace Quantum.Shor {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;
    open Microsoft.Quantum.Arithmetic;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Diagnostics;
    open Microsoft.Quantum.Arrays;

    // Implementação principal do algoritmo de Shor
    operation RunShorAlgorithm(N : Int, a : Int) : (Int, Int) {
        // Passo 1: Verificar se N é par
        if (N % 2 == 0) {
            return (2, N / 2);
        }

        // Passo 2: Verificar se a e N são coprimos
        let gcd = GreatestCommonDivisor(a, N);
        if (gcd != 1) {
            return (gcd, N / gcd);
        }

        // Passo 3: Encontrar a ordem r de a módulo N (parte quântica)
        let r = FindOrder(a, N);

        // Passo 4: Se r é ímpar, tentar novamente
        if (r % 2 == 1) {
            fail "Ordem ímpar encontrada. Tente outro valor de a.";
        }

        // Passo 5: Calcular a^(r/2) mod N
        let x = PowModI(a, r / 2, N);

        // Passo 6: Verificar se x ≡ -1 mod N
        if (x == N - 1) {
            fail "x ≡ -1 mod N. Tente outro valor de a.";
        }

        // Passo 7: Calcular os fatores
        let p = GreatestCommonDivisor(x + 1, N);
        let q = GreatestCommonDivisor(x - 1, N);

        return (p, q);
    }

    // Operação para encontrar a ordem (parte quântica)
    operation FindOrder(a : Int, N : Int) : Int {
        // Determinar o número de qubits necessários
        let n = BitSize(N);
        let size = 2 * n;

        // Alocar registradores quânticos
        using ((register, eigenstate) = (Qubit[size], Qubit[n])) {
            // Inicializar o eigenstate em |1>
            X(eigenstate[0]);

            // Aplicar estimativa de fase quântica
            QuantumPhaseEstimation(
                ModularExponentiationLE(a, N, _, _),
                LittleEndian(eigenstate),
                BigEndian(register)
            );

            // Medir o registrador
            let result = MeasureInteger(BigEndian(register));

            // Liberar qubits
            ResetAll(register);
            ResetAll(eigenstate);

            // Processar o resultado para encontrar a ordem r
            return ProcessMeasurement(result, size, N);
        }
    }

    // Processar a medição para encontrar a ordem r
    function ProcessMeasurement(measured : Int, size : Int, N : Int) : Int {
        // Converter para fração usando o algoritmo de frações contínuas
        let (numerator, denominator) = ContinuedFractions(measured, size, N);

        // Verificar se o denominador é a ordem
        if (PowModI(measured, denominator, N) == 1) {
            return denominator;
        }

        // Tentar múltiplos do denominador
        for (k in 1..10) {
            let candidate = k * denominator;
            if (PowModI(measured, candidate, N) == 1) {
                return candidate;
            }
        }

        // Se não encontrou, retorna o melhor palpite
        return denominator;
    }

    // Implementação da exponenciação modular para LittleEndian
    operation ModularExponentiationLE(
        a : Int,
        N : Int,
        target : LittleEndian,
        control : Qubit[]
    ) : Unit is Adj + Ctl {
        let aList = IntAsBoolArray(a, BitSize(N));
        let NList = IntAsBoolArray(N, BitSize(N));
        
        ModularExponentiation(
            aList,
            NList,
            target!,
            control
        );
    }

    // Algoritmo de frações contínuas
    function ContinuedFractions(measured : Int, size : Int, N : Int) : (Int, Int) {
        mutable numerator = 0;
        mutable denominator = 1;
        mutable x = measured;
        mutable y = PowI(2, size);
        mutable a = x / y;

        while (x != a * y) {
            let newNumerator = a * denominator + numerator;
            numerator = denominator;
            denominator = newNumerator;
            let newX = y;
            y = x - a * y;
            x = newX;
            a = x / y;
        }

        return (numerator, denominator);
    }

    // Função auxiliar para calcular o máximo divisor comum
    function GreatestCommonDivisor(a : Int, b : Int) : Int {
        mutable x = a;
        mutable y = b;
        
        while (y != 0) {
            let r = x % y;
            set x = y;
            set y = r;
        }
        
        return x;
    }

    // Função auxiliar para exponenciação modular
    function PowModI(a : Int, power : Int, modulus : Int) : Int {
        mutable result = 1;
        mutable aPow = a % modulus;
        mutable remainingPower = power;
        
        while (remainingPower > 0) {
            if (remainingPower % 2 == 1) {
                set result = (result * aPow) % modulus;
            }
            set aPow = (aPow * aPow) % modulus;
            set remainingPower = remainingPower / 2;
        }
        
        return result;
    }

    // Operação de teste
    operation TestShorAlgorithm() : (Int, Int) {
        let N = 15;  // Número a ser fatorado
        let a = 7;   // Base aleatória coprima com N
        
        Message($"Fatorando {N} usando a = {a}...");
        let (p, q) = RunShorAlgorithm(N, a);
        Message($"Fatores encontrados: {p} e {q}");
        
        return (p, q);
    }
}