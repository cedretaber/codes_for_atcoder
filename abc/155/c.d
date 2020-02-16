import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    int[string] ss;
    foreach (_; 0..N) ++ss[readln.chomp];
    int max_n;
    foreach (_, n; ss) max_n = max(max_n, n);
    string[] rs;
    foreach (s, n; ss) if (n == max_n) rs ~= s;
    sort(rs);
    foreach (r; rs) writeln(r);
}