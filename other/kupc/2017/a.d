import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = readln.split.to!(int[]);
    sort!"a > b"(as);
    int k, r;
    foreach (a; as) {
        k += a;
        ++r;
        if (k >= K) break;
    }
    writeln(k >= K ? r : -1);
}