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

int[10^^4+1] MEMO;

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
    sort!"a[0] > b[0]"(MS);

    int solve(int n) {
        if (!n) return 0;
        if (MEMO[n]) return MEMO[n];
        auto r = int.min;
        foreach (m; MS) if (n - m[1] >= 0) {
            r = max(r, solve(n - m[1]) + 1);
        }
        return MEMO[n] = r;
    }

    auto k = solve(N);
    foreach (_; 0..k+1) {
        foreach (m; MS) {
            if (N - m[1] >= 0 && MEMO[N] == MEMO[N - m[1]] + 1) {
                N -= m[1];
                write(m[0]);
                break;
            }
        }
    }
    writeln("");
}