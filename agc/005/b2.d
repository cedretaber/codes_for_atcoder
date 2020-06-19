import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto N = readln.chomp.to!long;
    int[] aa;
    auto ii = new long[](N+1);
    foreach (i, a; readln.split.to!(int[])) {
        aa ~= a;
        ii[a] = i.to!int;
    }

    auto rbt = redBlackTree(-1, N);
    long res;
    foreach (long a; 1..N+1) {
        auto ls = rbt.lowerBound(ii[a]);
        auto l = ii[a] - ls.back;
        auto rs = rbt.upperBound(ii[a]);
        auto r = rs.front - ii[a];
        res += (l * r) * a;
        rbt.insert(ii[a]);
    }
    writeln(res);
}