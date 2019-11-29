import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long f(long b, long n)
{
    long r;
    while (n) {
        r += n%b;
        n /= b;
    }
    return r;
}

void main()
{
    auto n = readln.chomp.to!long;
    auto s = readln.chomp.to!long;

    if (n == s) {
        writeln(n + 1);
    } else {
        long i = 1;
        for (;;) {
            ++i;
            if (i*i > n) break;
            if (f(i, n) == s) {
                writeln(i);
                return;
            }
        }
        i = 0;
        long min_b = long.max;
        for (;;) {
            ++i;
            if (i*i > n || s - i < 0) break;
            auto b = (n - s) / i + 1;
            if (b < 2) continue;
            if (f(b, n) == s) {
                min_b = min(min_b, b);
            }
        }
        writeln(min_b == long.max ? -1 : min_b);
    }
}