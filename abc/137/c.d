import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[string] SS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (_; 0..N) {
        auto s = readln.chomp.to!(dchar[]);
        sort(s);
        auto ss = s.to!string;
        if (ss !in SS) SS[ss] = 0;
        ++SS[ss];
    }
    long r;
    foreach (_, c; SS) if (c > 1) {
        r += c * (c-1) / 2;
    }
    writeln(r);
}