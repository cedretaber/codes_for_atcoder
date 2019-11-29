import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    int mousho, manats, nats, nettaiya, fuyubi, mafuyubi;
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto mm = readln.split.to!(double[]);
        auto M = mm[0];
        auto m = mm[1];
        if (M >= 35) ++mousho;
        if (M < 35 && M >= 30) ++manats;
        if (M < 30 && M >= 25) ++nats;
        if (m >= 25) ++nettaiya;
        if (m < 0 && M >= 0) ++fuyubi;
        if (M < 0) ++mafuyubi;
    }
    writefln("%d %d %d %d %d %d", mousho, manats, nats, nettaiya, fuyubi, mafuyubi);
}