import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!long;
    long s;
    foreach (i; 1..N+1) {
        if (i%3 != 0 && i%5 != 0) s += i;
    }
    writeln(s);
}