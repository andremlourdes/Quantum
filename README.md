# Quantum
# Quantum
#Implement the second phase of the quantum random number generator: combining multiple random bits to form a larger random number. This phase builds on the random bit generator you created in the previous unit.

Combine multiple random bits to form a larger number
In the previous unit, you created a random bit generator that generates a random bit by placing a qubit in superposition and measuring it.

When you measure the qubit, you will get a random bit, either 0 or 1, with equal probability of 50%. The value of this bit is truly random; there is no way to know what you will get after the measurement. But how can you use this behavior to generate larger random numbers?

Let's say you repeat the process four times, generating this sequence of binary digits:

If you concatenate or combine these bits into a string of bits, you can form a larger number. In this example, the sequence of bits
is equivalent to six in decimal.

If you repeat this process many times, you can combine multiple bits to form any large number.

Define the Logic of the Random Number Generator
Let's describe what the logic of a random number generator should be, given the random bit generator compiled in the previous unit:

Set max to the maximum number you want to generate.
Set the number of random bits you need to generate by calculating how many bits, nBits, you need to express integers up to max.
Generate a random bit string of length nBits.
If the bit string represents a number greater than max, go back to step three.
Otherwise, you're done. Return the generated number as an integer.
As an example, let's set max to 12. That is, 12 is the largest number you want to get from the random number generator.

You need
or four bits to represent a number between 0 and 12. (For brevity, we'll ignore how to derive this equation.)

Let's say you generate the bit string
, which is equivalent to
. Since 13 is greater than 12, you repeat the process.

You then generate the bit string
, which is equivalent to
. Since 6 is less than 12, the process is complete.

The quantum random number generator returns the number 6.
