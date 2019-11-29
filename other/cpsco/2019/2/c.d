import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    long d;
    long[] ks;
    foreach (c; readln.chomp) {
        if (c == '(') {
            ++d;
        } else {
            --d;
        }
        ks ~= d;
    }
    sort!"a > b"(ks);
    foreach (i; 0..K) d += ks[i];
    writeln(d);
}