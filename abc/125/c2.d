import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(long[]);
    auto cs = new long[](N);
    auto ds = new long[](N);
    cs[0] = as[0];
    foreach (i; 1..N) cs[i] = gcd(cs[i-1], as[i]);
    ds[$-1] = as[$-1];
    foreach_reverse (i; 0..N-1) ds[i] = gcd(ds[i+1], as[i]);
    long r = max(ds[1], cs[$-2]);
    foreach (i; 1..N-1) r = max(r, gcd(cs[i-1], ds[i+1]));
    writeln(r);
}