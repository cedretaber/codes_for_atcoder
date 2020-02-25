import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto d = readln.chomp.to!int;
    auto n = readln.chomp.to!int;
    auto m = readln.chomp.to!int;
    auto ss = [0, d];
    foreach (_; 0..n-1) ss ~= readln.chomp.to!int;
    sort(ss);
    long res;
    foreach (_; 0..m) {
        auto k = readln.chomp.to!int;
        size_t l, r = ss.length-1;
        while (l+1 < r) {
            auto i = (l+r)/2;
            if (ss[i] < k) {
                l = i;
            } else {
                r = i;
            }
        }
        res += min(k-ss[l], ss[r]-k);
    }
    writeln(res);
}