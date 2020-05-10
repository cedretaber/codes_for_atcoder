import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(long[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = readln.split.to!(int[]).map!"a - 1"().array();
    int[] bs = [0];
    auto memo = new int[](N);
    int n = as[0];
    foreach (i; 1..N) {
        if (n == 0 || memo[n]) break;
        memo[n] = i.to!int;
        bs ~= n;
        n = as[n];
    }
    if (K < bs.length) {
        writeln(bs[K]+1);
    } else {
        auto f = memo[n];
        K -= f;
        bs = bs[f..$];
        writeln(bs[K%bs.length]+1);
    }
}