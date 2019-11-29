import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias DF = Tuple!(size_t, "idx", long, "up");

long[10^^5] BS, LS, US, SUM_D;
DF[10^^5] DFS;

void main()
{
    auto nx = readln.split.to!(long[]);
    auto N = nx[0];
    auto X = nx[1];

    long sum_d;
    foreach (i; 0..N) {
        auto blu = readln.split.to!(long[]);
        auto b = blu[0];
        auto l = blu[1];
        auto u = blu[2];
        BS[i] = b;
        LS[i] = l;
        US[i] = u;
        DFS[i] = DF(i, X * u - b * u + b * l);
        sum_d -= b * l;
    }

    sort!"a.up > b.up"(DFS[0..N]);

    foreach (i; 0..N) {
        if (!i) {
            SUM_D[i] = sum_d;
        } else {
            auto idx = DFS[i-1].idx;
            SUM_D[i] = SUM_D[i-1] + BS[idx] * LS[idx] - BS[idx] * US[idx] + X * US[idx];
        }
    }

    long min_r = -1, max_r = X * N;
    while (min_r + 1 != max_r) {
        auto mid_r = (min_r + max_r) / 2;
        bool can_win;
        auto len = mid_r / X;
        auto ap = mid_r % X;

        foreach (i; 0..N) {
            auto D = SUM_D[len];
            auto idx = DFS[i].idx;
            if (i < len) {
                auto ldx = DFS[len].idx;
                D = D - X * US[idx] + X * US[ldx];
                D = D + BS[idx] * US[idx] - BS[idx] * LS[idx];
                D = D + BS[ldx] * LS[ldx] - BS[ldx] * US[ldx];
            }
            if (ap < BS[idx]) {
                D += ap * LS[idx];
            } else {
                D = D + BS[idx] * LS[idx] - BS[idx] * US[idx];
                D = D + ap * US[idx];
            }
            
            if (D >= 0) {
                can_win = true;
                break;
            }
        }

        if (can_win) {
            max_r = mid_r;
        } else {
            min_r = mid_r;
        }
    }

    writeln(max_r);
}