import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias SP = Tuple!(int, "idx", string, "s", int, "p");
SP[] SPS;

void main()
{
    auto N = readln.chomp.to!int;
    SPS.length = N;
    foreach (int i; 0..N) {
        auto sp = readln.split;
        SPS[i] = SP(i+1, sp[0].to!string, sp[1].to!int);
    }
    sort!"a.s == b.s ? a.p > b.p : a.s < b.s"(SPS);
    foreach (sp; SPS) writeln(sp.idx);
}