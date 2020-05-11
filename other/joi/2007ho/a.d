import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    int s;
    int[] as;
    foreach (i; 0..N) {
        auto a = readln.chomp.to!int;
        as ~= a;
        if (i < K) s += a;
    }
    int max_s = s;
    foreach (i; K..N) {
        s = s + as[i] - as[i-K];
        max_s = max(s, max_s);
    }
    writeln(max_s);
}