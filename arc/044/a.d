import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    if (N == 1) {
        writeln("Not Prime");
        return;
    }
    for (int i = 2; i^^2 <= N; ++i) {
        if (N%i == 0) {
            auto n = N.to!(char[]);
            auto one = n[$-1] - '0';
            int sum;
            foreach (c; n) sum += c - '0';
            writeln(one%2 == 0 || one == 5 || sum%3 == 0 ? "Not Prime" : "Prime");
            return;
        }
    }
    writeln("Prime");
}