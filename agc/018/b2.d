import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];
    int[][] aa;
    foreach (i; 0..N) aa ~= readln.split.map!(a => a.to!int-1).array;
    auto ss = new bool[](M);
    ss[] = true;
    auto r = N+1;
    foreach (_; 0..M) {
        auto ps = new int[](M);
        foreach (i; 0..N) {
            foreach (s; aa[i]) if (ss[s]) {
                ps[s] += 1;
                break;
            }
        }
        int max_p;
        size_t k;
        foreach (i, p; ps) if (p > max_p) {
            max_p = p;
            k = i;
        }
        r = min(r, max_p);
        ss[k] = false;
    }
    writeln(r);
}