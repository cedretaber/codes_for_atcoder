import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nt = readln.split.to!(int[]);
    auto N = nt[0];
    auto T = nt[1];
    int last;
    foreach (a; readln.split.to!(int[])) {
        auto k = max(0, (last - a + T - 1) / T);
        last = k*T + a;
    }
    writeln(last);
}