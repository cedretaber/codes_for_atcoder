import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto LS = readln.split.to!(int[]);
    long c;
    foreach (i; 0..N-2) {
        foreach (j; i+1..N-1) {
            foreach (k; j+1..N) {
                if (
                    LS[i] < LS[j] + LS[k] &&
                    LS[j] < LS[i] + LS[k] &&
                    LS[k] < LS[i] + LS[j]
                ) ++c;
            }
        }
    }
    writeln(c);
}