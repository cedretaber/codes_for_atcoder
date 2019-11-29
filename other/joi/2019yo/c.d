import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    int s;
    for (int i; i < N; ++i) {
        if (i+1 < N && S[i] != S[i+1]) {
            ++s;
            ++i;
        }
    }
    writeln(s);
}