import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nx = readln.split.to!(int[]);
    auto N = nx[0];
    long X = nx[1];
    auto S = readln.chomp;
    long s;
    foreach (i; 0..N) {
        auto t = readln.chomp.to!long;
        s += S[i] == '0' ? t : min(t, X);
    }
    writeln(s);
}