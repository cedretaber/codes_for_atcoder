import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto kn = readln.split.to!(int[]);
    auto K = kn[0];
    auto N = kn[1];
    auto as = readln.split.to!(int[]);
    int max_a = K - as[$-1] + as[0];
    foreach (i; 0..N-1) max_a = max(max_a, as[i+1] - as[i]);
    writeln(K - max_a);
}