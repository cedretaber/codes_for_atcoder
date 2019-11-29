import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto ws = new string[](N);
    foreach (i; 0..N) {
        ws[i] = readln.chomp;
    }
    auto w = ws[0];
    auto D = [w: true];
    foreach (i, v; ws[1..$]) {
        if (v in D || w[$-1] != v[0]) {
            writeln(i%2 == 0 ? "WIN" : "LOSE");
            return;
        }
        D[v] = true;
        w = v;
    }
    writeln("DRAW");
}