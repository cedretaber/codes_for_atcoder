import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto M = readln.chomp.to!int;
    auto S = readln.chomp ~ 'X';

    auto DP = new int[](M);
    foreach (i; 0..M) {
        if (S[i] == 'I' && S[i+1] == 'O') {
            if (i) DP[i+1] = DP[i-1];
            DP[i+1] += 1;
        }
    }
    int r;
    foreach (i; 0..M) if (S[i+1] == 'I' && DP[i] >= N) ++r;
    writeln(r);
}