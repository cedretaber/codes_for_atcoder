import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

uint[10^^5] BS;

void main()
{
    auto L = readln.chomp.to!int;
    foreach (i; 0..L) BS[i] = readln.chomp.to!uint;

    uint x;
    uint[] r;
    foreach (i; 0..L-1) {
        r ~= x;
        x ^= BS[i];
    }
    if ((BS[L-1] ^ x) == 0) {
        r ~= x;
        foreach (rr; r) writeln(rr);
    } else {
        writeln("-1");
    }
}