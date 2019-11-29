import std.stdio, std.algorithm, std.conv, std.array, std.string;

long N = 10^^9 + 7;

void main()
{
    auto n = readln.chomp.to!int;
    auto as = readln.split.to!(long[]).sort();

    if (n == 1) {
        writeln(as[0] == 0 ? "1" : "0");
        return;
    }

    if (n&1) as = as[1..$];

    for (size_t i = 0; i < n-1; ++i) {
        if (as[i] != as[++i]) {
            writeln("0");
            return;
        }
    }

    long fact(long n) {
        if (n == 1) {
            return 2;
        } else if (n&1) {
            return 2 * fact(n/2) * fact(n/2) % N;
        } else {
            return fact(n/2) * fact(n/2) % N;
        }
    }
    writeln(fact(n / 2));
}