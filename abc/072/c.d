import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

int[10^^5+2] CNT;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    foreach (a; as) {
        CNT[a == 0 ? 10^^5+1 : a-1]++;
        CNT[a]++;
        CNT[a+1]++;
    }
    int m = 0;
    foreach (cnt; CNT) {
        m = max(cnt, m);
    }
    writeln(m);
}