import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nkq = readln.split.to!(long[]);
    auto N = nkq[0];
    auto K = nkq[1];
    auto Q = nkq[2];
    int[] as;
    as.length = N;
    foreach (_; 0..Q) {
        ++as[readln.chomp.to!int - 1];
    }
    foreach (a; as) {
        writeln(K - (Q - a) > 0 ? "Yes" : "No");
    }
}