import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

int[][] read_tree_without_cost(int N) {
    auto T = new int[][N];
    foreach (_; 1..N) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        T[A] ~= B;
        T[B] ~= A;
    }
    return T;
}

Tuple!(int, int) calc_diametor(int N, int[][] T) {
    alias S = Tuple!(int, "i", int, "c");

    auto DP = new int[](N);
    DP[] = int.max/3;
    DP[0] = 0;
    auto Q = heapify!"a.c < b.c"([S(0, 0)]);
    while (!Q.empty) {
        auto i = Q.front.i;
        auto c = Q.front.c;
        Q.popFront();
        if (DP[i] < c) continue;
        foreach (j; T[i]) if (DP[j] > c + 1) {
            DP[j] = c + 1;
            Q.insert(S(j, c + 1));
        }
    }
    int s, max_c;
    foreach (i, c; DP) if (c > max_c) {
        s = i.to!int;
        max_c = c;
    }
    Q.insert(S(s, 0));
    DP[] = int.max/3;
    DP[s] = 0;
    while (!Q.empty) {
        auto i = Q.front.i;
        auto c = Q.front.c;
        Q.popFront();
        if (DP[i] < c) continue;
        foreach (j; T[i]) if (DP[j] > c + 1) {
            DP[j] = c + 1;
            Q.insert(S(j, c + 1));
        }
    }
    int t;
    max_c = 0;
    foreach (i, c; DP) if (c > max_c) {
        t = i.to!int;
        max_c = c;
    }
    return tuple(s, t);
}

void main()
{
    auto N = readln.chomp.to!int;
    auto T = read_tree_without_cost(N);
    auto st = calc_diametor(N, T);
    writeln(st[0]+1, " ", st[1]+1);
}