import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto S = readln.chomp;
    auto N = S.length;
    long min_n;
    auto ns = new long[](N+1);
    long x;
    foreach (i; 1..N+1) {
        if (S[i-1] == '<') {
            ns[i] = ++x;
        } else {
            x = 0;
        }
    }
    x = 0;
    foreach_reverse (i; 0..N) {
        if (S[i] == '>') {
            ns[i] = max(ns[i], ++x);
        } else {
            x = 0;
        }
    }
    writeln(0L.reduce!"a + b"(ns));
}