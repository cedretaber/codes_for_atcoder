import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    long[] as;
    foreach (i, a; readln.split.to!(long[])) as ~= a - i.to!long - 1;
    sort(as);
    long b;
    if (N%2 == 1) {
        b = as[N/2];
    } else {
        b = (as[N/2-1] + as[N/2]) / 2;
    }
    long s;
    foreach (a; as) s += abs(a - b);
    writeln(s);
}