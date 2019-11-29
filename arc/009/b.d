import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

void main()
{
    auto ntoa = readln.split.to!(int[]);
    int[] aton;
    aton.length = 10;
    foreach (i, a; ntoa) aton[a] = i.to!int;

    auto N = readln.chomp.to!int;
    int[] as;
    as.length = N;
    foreach (i; 0..N) {
        auto a = readln.chomp.to!(char[]);
        foreach (ref c; a) c = (aton[c - '0'] + '0').to!char;
        as[i] = a.to!int;
    }
    sort(as);
    foreach (a; as) {
        char[] b;
        foreach (c; a.to!string) b ~= (ntoa[c - '0'] + '0').to!char;
        writeln(b);
    }
}