import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto s = readln.chomp;
    auto t = readln.chomp;

    foreach (i; 0..N+1) {
        if (s[i..$] == t[0..N-i]) {
            writeln(N + i);
            return;
        }
    }
}