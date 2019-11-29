import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto N = readln.chomp.to!int;
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];

    if (A >= N) {
        writeln("Takahashi");
    } else if (A == B) {
        writeln(N%(A+1) == 0 ? "Aoki" : "Takahashi");
    } else {
        writeln(A > B ? "Takahashi" : "Aoki");
    }
}