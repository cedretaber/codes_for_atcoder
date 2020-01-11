import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto ss = new string[](N);
    auto ts = new int[](N);
    foreach (i; 0..N) {
        auto st = readln.split;
        ss[i] = st[0];
        ts[i] = st[1].to!int;
    }
    auto X = readln.chomp;
    int r;
    foreach (i; 0..N) {
        r += ts[i];
        if (ss[i] == X) r = 0;
    }
    writeln(r);
}