import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    auto ps = readln.split.to!(int[]);
    auto cs = new long[](N);
    foreach (i; 0..M-1) {
        auto a = ps[i]-1;
        auto b = ps[i+1]-1;
        if (a > b) swap(a, b);
        ++cs[a];
        --cs[b];
    }
    long r;
    foreach (i; 0..N-1) {
        cs[i+1] += cs[i];
        auto abc = readln.split.to!(long[]);
        auto a = abc[0];
        auto b = abc[1];
        auto c = abc[2];
        r += min(a * cs[i], b * cs[i] + c);
    }
    writeln(r);
}