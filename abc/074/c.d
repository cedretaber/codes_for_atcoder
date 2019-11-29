import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.numeric, std.typecons;

bool[3001][3001] RESULT;

void main()
{
    auto it = readln.split.to!(int[]);
    auto A = it[0];
    auto B = it[1];
    auto C = it[2];
    auto D = it[3];
    auto E = it[4];
    auto F = it[5];

    void solve(int a, int b) {
        if (a + b > F || RESULT[a][b] || b * 100 > a * E) return;
        RESULT[a][b] = true;

        solve(a + 100 * A, b);
        solve(a + 100 * B, b);
        solve(a, b + C);
        solve(a, b + D);
    }

    solve(0, 0);

    size_t max_a, max_b;
    foreach (a, rs; RESULT) {
        foreach (b, r; rs) {
            if (r) {
                if (max_a == 0 && max_b == 0) {
                    max_a = a;
                    max_b = b;
                } else if ((b == 0 ? 0 : b * (max_a + max_b)) > (max_b == 0 ? 0 : max_b * (a + b))) {
                    max_a = a;
                    max_b = b;
                }
            }
        }
    }

    writefln("%s %s", max_a + max_b, max_b);
}