import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto ts = new int[](N);
    foreach (i; 0..N) ts[i] = readln.chomp.to!int;

    int[2] solve(int i, int a, int b) {
        if (i == N) return [a, b];
        auto r1 = solve(i+1, a + ts[i], b);
        auto r2 = solve(i+1, a, b + ts[i]);
        if (max(r1[0], r1[1]) < max(r2[0], r2[1])) {
            return r1;
        } else {
            return r2;
        }
    }

    auto r = solve(0, 0, 0);
    writeln(max(r[0], r[1]));
}