import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    auto AS = readln.split.to!(long[]);
    long sum_a;
    foreach (a; AS) sum_a += a;
    auto d = (N+1) * N / 2;
    if (sum_a % d != 0) {
        writeln("NO");
        return;
    }
    auto n = sum_a / d;

    d = 0;
    foreach (i; 0..N) {
        auto a = AS[(i+1)%N] - AS[i];
        if ((n-a)%N != 0 || n-a < 0 || n < (n-a)/N) {
            writeln("NO");
            return;
        }
        d += a;
    }
    
    writeln(d == 0 ? "YES" : "NO");
}
