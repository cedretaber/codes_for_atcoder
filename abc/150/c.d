import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;

    int[] nn, xs;
    foreach (i; 1..N+1) nn ~= i;
    do {
        int x;
        foreach (i; 0..N) {
            x *= 10;
            x += nn[i];
        }
        xs ~= x;
    } while (nextPermutation(nn));
    sort(xs);
    int[int] rs;
    foreach (i, x; xs) {
        rs[x] = (i+1).to!int;
    }
    
    auto ps = readln.split.join.to!int;
    auto qs = readln.split.join.to!int;

    writeln(abs(rs[ps] - rs[qs]));
}