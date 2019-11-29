import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    if (N%2 == 1) {
        writeln("No");
        return;
    }
    foreach (i; 0..N/2) {
        if (S[i] != S[N/2+i]) {
            writeln("No");
            return;
        }
    }
    writeln("Yes");
}