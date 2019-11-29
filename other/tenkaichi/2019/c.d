import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[10^^5*2] BS, WS;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    foreach (i, c; S) {
        if (i) {
            BS[i] = BS[i-1];
            WS[i] = WS[i-1];
        }
        if (c == '#') {
            ++BS[i];
        } else {
            ++WS[i];
        }
    }
    int r = int.max;
    foreach (i; 0..N+1) {
        auto s = WS[N-1];
        if (i) {
            s -= WS[i-1];
            s += BS[i-1];
        }
        r = min(r, s);
    }
    writeln(r);
}