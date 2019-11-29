import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto S = readln.chomp.to!(char[]);
    for (size_t i; i <= S.length/2; ++i) {
        if (S[i] != S[$-i-1]) {
            writeln("NO");
            return;
        }
    }
    writeln("YES");
}