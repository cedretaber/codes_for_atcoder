import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto ny = readln.split.to!(int[]);
    auto N = ny[0];
    auto Y = ny[1] / 1000;

    foreach (i; 0..N+1) {
        foreach (j; 0..N+1) {
            if (i+j > N) continue;
            auto k = N - (i+j);
            if (i*10 + j*5 + k == Y) {
                writefln("%d %d %d", i, j, k);
                return;
            }
        }
    }
    writeln("-1 -1 -1");
}