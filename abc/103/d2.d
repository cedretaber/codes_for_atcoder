import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[10^^5] NS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0] - 1;
        auto b = ab[1] - 1;
        if (NS[a]) {
            NS[a] = min(NS[a], b);
        } else {
            NS[a] = b;
        }
    }

    int cnt, last = int.max;
    foreach (i, b; NS[0..N]) {
        if (i == last) {
            ++cnt;
            last = int.max;
        }
        if (b) {
            last = min(b, last);
        }
    }
    writeln(cnt);
}