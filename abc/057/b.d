import std.stdio, std.conv, std.string, std.array, std.algorithm, std.math;

void main()
{
    auto nm = readln.chomp.split(" ").map!(to!int);
    auto n = nm[0];
    auto m = nm[1];

    auto stus = new int[2][n];
    foreach (i; 0..n) stus[i] = readln.chomp.split(" ").map!(to!int).array;

    auto cps = new int[2][m];
    foreach (i; 0..m) cps[i] = readln.chomp.split(" ").map!(to!int).array;

    auto rets = new size_t[n];
    foreach (i, stu; stus) {
        auto min_v = int.max;
        size_t ret;
        
        foreach (j, cp; cps) {
            auto d = abs(stu[0] - cp[0]) + abs(stu[1] - cp[1]);
            if (d < min_v) {
                min_v = d;
                ret = j;
            }
        }
        rets[i] = ret + 1;
    }

    rets.each!writeln;
}