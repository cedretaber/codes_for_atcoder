import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nt = readln.split.to!(int[]);
    auto N = nt[0];
    auto T = nt[1];
    int[2][] cts;
    cts.length = N;
    foreach (i; 0..N) {
        auto ct = readln.split.to!(int[]);
        cts[i] = [ct[0], ct[1]];
    }
    sort!"a[0] < b[0]"(cts);
    foreach (ct; cts) {
        if (ct[1] <= T) {
            writeln(ct[0]);
            return;
        }
    }
    writeln("TLE");
}