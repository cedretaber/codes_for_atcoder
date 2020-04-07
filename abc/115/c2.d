import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int[] hs;
    foreach (_; 0..N) hs ~= readln.chomp.to!int;
    sort(hs);
    int min_d = int.max;
    foreach (i; 0..N-K+1) {
        min_d = min(min_d, hs[i+K-1] - hs[i]);
    }
    writeln(min_d);
}