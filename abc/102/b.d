import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    int max_a = int.min;
    foreach (i; 0..N-1) {
        foreach (j; i+1..N) {
            max_a = max(max_a, abs(AS[i] - AS[j]));
        }
    }
    writeln(max_a);
}