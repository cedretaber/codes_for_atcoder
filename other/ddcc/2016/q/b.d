import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = readln.split.to!(int[]);
    int[][] ns;
    ns.length = 10^^5+1;
    int max_a;
    foreach (i, a; as) {
        max_a = max(a, max_a);
        ns[a] ~= i.to!int;
    }
    int last = -1, r = 1;
    foreach (i; 0..10^^5+1) {
        if (ns[i].empty) continue;
        size_t j;
        while (j < ns[i].length && ns[i][j] < last) ++j;
        if (j == 0) {
            last = ns[i][$-1];
        } else {
            last = ns[i][j-1];
            if (last != 0 || i != max_a) ++r;
        }
    }
    writeln(r);
}