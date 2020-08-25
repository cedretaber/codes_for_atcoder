import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto ab = readln.split.to!(int[]);
    int M;
    if (ab.length == 2) {
        M = ab[1];
    } else {
        M = readln.chomp.to!int;
    }
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);

    int r;
    foreach (j; 0..M) {
        auto k = j;
        foreach (a; AS) {
            if (k == M) break;
            if (a == BS[k]) ++k;
        }
        r = max(r, k - j);
    }
    writeln(r); 
}