import std.stdio, std.algorithm, std.conv, std.array, std.string, std.numeric;

ulong[100] TS;

T lcm(T)(T a, T b)
{
    return a / gcd(a, b) * b;
}

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        TS[i] = readln.chomp.to!ulong;
    }
    auto res = TS[0];
    foreach (t; TS[1..N]) {
        res = lcm(res, t);
    }
    writeln(res);
}