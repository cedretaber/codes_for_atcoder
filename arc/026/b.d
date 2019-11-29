import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!long;

    if (N == 1) {
        writeln("Deficient");
        return;
    }

    long n = 1;
    for (long x = 2; x^^2 <= N; ++x) if (N % x == 0) {
        n += x;
        if (x^^2 < N) n += N / x;
    }

    writeln(n < N ? "Deficient" : n > N ? "Abundant" : "Perfect");
}