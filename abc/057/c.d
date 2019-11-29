import std.stdio, std.conv, std.string, std.array, std.algorithm, std.math;

void main()
{
    auto n = readln.chomp.to!ulong;

    auto i = 2;
    ulong[] primes;
    while (n != 1) {
        if (n%i == 0) {
            primes ~= i;
            n /= i;
        } else {
            i += 1;
        }
    }
    ulong a = 1, b = 1;
    foreach_reverse (p; primes) {
        if (a > b)
            b *= p;
        else
            a *= p;
    }
    (a > b ? a : b).to!string.count.writeln;
}