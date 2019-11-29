import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5] HS;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];

    foreach (i; 0..N) HS[i] = readln.chomp.to!int;
    sort(HS[0..N]);

    auto min_h = HS[N-1];
    foreach (i; 0..N-K+1) {
        min_h = min(min_h, HS[i+K-1] - HS[i]);
    }
    writeln(min_h);
}