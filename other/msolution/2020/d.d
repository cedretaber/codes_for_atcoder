import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);

    auto ts = new int[](N);
    ts[N-1] = 2;
    foreach (i; 0..N-1) {
        if (AS[i] < AS[i+1]) {
            ts[i] = 1;
        } else if (AS[i] > AS[i+1]) {
            ts[i] = 2;
        }
    }
    long m = 1000L, a;
    foreach (i; 0..N) {
        if (ts[i] == 1) {
            auto x = m / AS[i];
            m -= x * AS[i];
            a += x;
        } else if (ts[i] == 2) {
            m += a * AS[i];
            a = 0;
        }
    }
    writeln(m);
}