import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nmk = readln.split.to!(int[]);
    auto N = nmk[0];
    auto M = nmk[1];
    auto K = nmk[2];

    foreach (y; 0..N+1) {
        foreach (x; 0..M+1) {
            if (x*y + (M-x)*(N-y) == K) {
                writeln("Yes");
                return;
            }
        }
    }
    writeln("No");
    return;
}