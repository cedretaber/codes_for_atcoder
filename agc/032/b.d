import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;

    string[] res;
    auto n = (N&126);
    foreach (i; 1..n+1) {
        foreach (j; i+1..n+1) {
            if (i + j == (N%2 == 0 ? N+1 : N)) continue;
            res ~= format("%d %d", i, j);
        }
        if (N%2 == 1) {
            res ~= format("%d %d", i, N);
        }
    }

    writeln(res.length);
    foreach (r; res) writeln(r);
}