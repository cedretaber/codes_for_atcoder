import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

enum P = 10L^^9+7;

long[10^^5*2+1] SS;
bool[10^^5*2+1] BS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    foreach (_; 0..M) {
        auto a = readln.chomp.to!int;
        BS[a] = true;
    }
    SS[0] = 1;
    foreach (i; 0..N) {
        if (BS[i]) continue;
        SS[i+1] = (SS[i+1] + SS[i]) % P;
        SS[i+2] = (SS[i+2] + SS[i]) % P;
    }
    writeln(SS[N]);
}