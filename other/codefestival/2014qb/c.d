import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    int[26] as, bs, cs;
    foreach (c; readln.chomp) ++as[c-'A'];
    foreach (c; readln.chomp) ++bs[c-'A'];
    foreach (c; readln.chomp) ++cs[c-'A'];
    int N;
    foreach (a; as) N += a;
    N /= 2;
    int min_a, max_a;
    foreach (i; 0..26) {
        min_a += max(0, cs[i] - bs[i]);
        max_a += min(as[i], cs[i]);
    }
    writeln(min_a <= N && N <= max_a ? "YES" : "NO");
}