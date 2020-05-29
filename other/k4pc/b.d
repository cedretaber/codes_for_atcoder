import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];
    auto rbt = redBlackTree([M]);
    long r;
    foreach (_; 0..N) {
        auto c = readln.chomp.to!long;
        if (!rbt.equalRange(c).empty) {
            continue;
        }
        long l = long.min/2, u = long.max/2;
        auto lb = rbt.lowerBound(c);
        if (!lb.empty) l = lb.back;
        auto ub = rbt.upperBound(c);
        if (!ub.empty) u = ub.front;
        
        r += min(abs(c - l), abs(u - c));
        rbt.insert(c);
    }
    writeln(r);
}