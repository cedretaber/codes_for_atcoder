import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons;

int[200][200] mk_map()
{
    int[200][200] ret;
    foreach (ref e; ret) e = int.max / 3;
    return ret;
}

int[200][200] MAP = mk_map();

void main()
{
    auto nmr = readln.split.to!(int[]);
    auto N = nmr[0];
    auto M = nmr[1];
    auto R = nmr[2];
    auto rs = readln.split.map!(s => s.to!int - 1).array;

    foreach (_; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0] - 1;
        auto b = abc[1] - 1;
        auto c = abc[2];
        MAP[a][b] = c;
        MAP[b][a] = c;
    }

    foreach (k; 0..N)
        foreach (i; 0..N)
            foreach (j; 0..N)
                if (MAP[i][j] > MAP[i][k] + MAP[k][j])
                    MAP[i][j] = MAP[i][k] + MAP[k][j];

    int[string][200] MEMO;
    int solve(int before, int[] rest) {
        if (rest.empty) return 0;
        auto key = rest.to!string;
        if (before != -1 && key in MEMO[before]) return MEMO[before][key];
        int min_ret = int.max;
        foreach (i, next; rest) {
            int ret;
            if (before >= 0) ret = MAP[before][next];
            ret += solve(next, rest[0..i] ~ rest[i+1..$]);
            min_ret = min(min_ret, ret);
        }
        if (before == -1) return min_ret;
        return MEMO[before][key] = min_ret;
    }

    writeln(solve(-1, rs));
}