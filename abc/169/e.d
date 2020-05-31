import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] AS, BS;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(long[]);
        AS ~= ab[0];
        BS ~= ab[1];
    }
    sort(AS);
    sort(BS);
    long l, r;
    if (N%2 == 0) {
        l = AS[N/2] + AS[N/2-1];
        r = BS[N/2] + BS[N/2-1];
    } else {
        l = AS[N/2];
        r = BS[N/2];
    }
    writeln(r - l + 1);
}