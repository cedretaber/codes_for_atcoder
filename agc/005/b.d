import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container.rbtree;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    int[] bs;
    bs.length = N;
    foreach (i, a; as) bs[a-1] = i.to!int + 1;

    auto rbt = redBlackTree(0, N+1);
    long s;
    foreach (int i; 0..N) {
        auto a = bs[i];
        auto l = rbt.lowerBound(a).back;
        auto r = rbt.upperBound(a).front;
        s += (a-l).to!long * (r-a).to!long * (i+1).to!long;
        rbt.insert(a);
    }
    writeln(s);
}