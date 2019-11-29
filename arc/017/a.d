import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    for (int i = 2; i*i <= N; ++i) {
        if (N % i == 0) {
            writeln("NO");
            return;
        }
    }
    writeln("YES");
}