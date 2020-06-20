import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto N = readln.chomp.to!int;
    auto hh = new int[][10^^5+1];
    foreach (i; 0..N) {
        auto h = readln.chomp.to!int;
        hh[h] ~= i;
    }

    auto rr = new int[N];
    auto rbt = redBlackTree(-1, N);
    foreach_reverse (h; 0..10^^5+1) {
        foreach (i; hh[h]) {
            rr[i] = rbt.upperBound(i).front - rbt.lowerBound(i).back - 2;
        }
        foreach (i; hh[h]) rbt.insert(i);
    }
    foreach (r; rr) writeln(r);
}