import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    long[] ts;
    foreach (_n; 0..N) {
        auto XYZ = readln.split.to!(int[]);
        auto X = XYZ[0];
        auto Y = XYZ[1];
        auto Z = XYZ[2];
        auto M = readln.chomp.to!int;
        int[] xs, ys, zs;
        foreach (_m; 0..M) {
            auto xyz = readln.split.to!(int[]);
            xs ~= xyz[0];
            ys ~= xyz[1];
            zs ~= xyz[2];
        }
        sort(xs);
        sort(ys);
        sort(zs);

        ts ~= xs[0];
        ts ~= X - xs[$-1] - 1;
        ts ~= ys[0];
        ts ~= Y - ys[$-1] - 1;
        ts ~= zs[0];
        ts ~= Z - zs[$-1] - 1;
    }

    int x;
    foreach (t; ts) x ^= t;
    writeln(x != 0 ? "WIN" : "LOSE");
}