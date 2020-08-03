import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto N = readln.chomp.to!int;
    auto as = new int[][10^^5+1];
    int max_a;
    foreach (i, a; readln.split.to!(int[])) {
        max_a = max(max_a, a);
        as[a] ~= i.to!int;
    }

    int r = -1, c;
    foreach (a; 1..max_a+1) {
        if (as[a].empty) continue;
        if (as[a][0] > r) {
            r = as[a][$-1];
        } else {
            if (as[a][$-1] < r) {
                r = as[a][$-1];
            } else {
                foreach (i, b; as[a]) if (b > r) {
                    r = as[a][i-1];
                    break;
                }
            }
            if (a != max_a || r != 0) ++c;
        }
    }
    writeln(c+1);
}