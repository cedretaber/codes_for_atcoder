import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

void main()
{
    auto N = readln.chomp.to!int;
    auto xs = readln.split.to!(long[]);
    auto cs = readln.split.to!(long[]);
    auto vs = readln.split.to!(long[]);

    long max_p, money;
    foreach (i; 0..N) {
        long[long][] memo;
        memo.length = N;
        long solve(int i, long res) {
            if (i == N) return 0;
            if (res in memo[i]) return memo[i][res];
            if (cs[i] == 0 || res < cs[i]) return memo[i][res] = solve(i+1, res);
            return memo[i][res] = max(solve(i+1, res), vs[i] + solve(i+1, res - cs[i]));
        }
        if (money > 0) max_p = max(max_p, solve(0, money));

        money += xs[i];

        Tuple!(int, long, long)[] list;
        list.length = N;
        foreach (ref e; list) {
            e[0] = -1;
            e[1] = long.max;
            e[2] = long.min;
        }
        foreach (j; 0..N) {
            if (cs[j] == 0) continue;
            auto tmp = cs[j];
            cs[j] = 0;
            list[j][0] = j;
            foreach (ref e; memo) foreach (k; e.keys) e.remove(k);
            list[j][1] = solve(0, money);
            list[j][2] = vs[j];
            cs[j] = tmp;
        }
        list.sort!"a[0] == -1 ? false : b[0] == -1 ? true : a[1] == b[1] ? a[2] > b[2] : a[1] < b[1]";
        writeln(list);
        int j;
        foreach (k; 0..N) if (list[k][0] != -1) {
            j = list[k][0];
            max_p = max(max_p, list[k][1]);
            break;
        }
        cs[j] = 0;
    }

    writeln(max_p);
}