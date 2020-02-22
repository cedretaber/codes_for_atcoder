import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(int[]);
    auto BS = readln.split.to!(int[]);
    foreach (i; 1..N) {
        AS[i] += AS[i-1];
        BS[i] += BS[i-1];
    }
    int r;
    foreach (i; 0..N) {
        r = max(r, AS[i] + BS[N-1] - (i == 0 ? 0 : BS[i-1]));
    }
    writeln(r);
}