import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias NN = Tuple!(int, int);

NN[10] MSS = [
    NN(0, int.max),
    NN(1, 2),
    NN(2, 5),
    NN(3, 5),
    NN(4, 4),
    NN(5, 5),
    NN(6, 6),
    NN(7, 3),
    NN(8, 7),
    NN(9, 6)
];

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto as = readln.split.to!(int[]);

    NN[] ms;
    foreach (a; as) ms ~= MSS[a];
    sort!"a[1] == b[1] ? a[0] > b[0] : a[1] < b[1]"(ms);

    bool[int] nn;
    NN[] MS;
    foreach (m; ms) {
        if (m[1] !in nn) {
            nn[m[1]] = true;
            MS ~= m;
        }
    }
    sort!"a[1] < b[1]"(MS);

    NN[] solve(int i, int n) {
        if (i == MS.length && n) return [];
        if (i == MS.length) return [NN(0, 0)];

        auto max_n = n / MS[i][1];
        foreach_reverse (m; 0..max_n+1) {
            auto r = solve(i+1, n - MS[i][1] * m);
            if (r) {
                r ~= NN(MS[i][0], m);
                return r;
            }
        }
        return [];
    }

    auto r = solve(0, N);
    sort!"a[0] > b[0]"(r);
    foreach (n; r) if (n[0]) {
        foreach (_; 0..n[1]) {
            write(n[0]);
        }
    }
    writeln("");
}