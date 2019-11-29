import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto S = readln.chomp;
    char last;
    int cnt;
    foreach (c; S) {
        if (c != last) ++cnt;
        last = c;
    }
    writeln(cnt);
}