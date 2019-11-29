import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

alias Path = Tuple!(int, "to", long, "d");

Path[100_000] NS;

void main()
{
    auto nm = readln.chomp.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto st = readln.chomp.to!(int[]);
    auto S = st[0];
    auto T = st[1];

    foreach (i; 0..M) {
        auto uvd = readln.chomp;
        auto U = uvd[0].to!int - 1;
        auto V = uvd[1].to!int - 1;
        auto D = uvd[2].to!long;

        NS[V] = Path(U, D);
        NS[U] = Path(V, D);
    }
}