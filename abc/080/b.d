import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;

    auto n = N;
    int s;
    while (n) {
        s += n % 10;
        n /= 10;
    }
    writeln(N % s ? "No" : "Yes");
}