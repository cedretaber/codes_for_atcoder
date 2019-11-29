import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

long f(long b, long n)
{
    return n < b ? n : f(b, n / b) + n % b;
}

void main()
{
    auto n = readln.chomp.to!long;
    auto s = readln.chomp.to!long;

    for (long b = 2; b < n; ++b) {
        if (f(b, n) == s) {
            writeln(b);
            return;
        }
    }
    writeln("-1");
}