import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5] G;
bool[10^^5] MEMO;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto A = ab[0]-1;
        auto B = ab[1]-1;
        G[A] ~= B;
        G[B] ~= A;
    }

    auto r = [0];
    MEMO[0] = true;
    void solve() {
        for (;;) {
            auto p = r[$-1];
            foreach (q; G[p]) if (!MEMO[q]) {
                r ~= q;
                MEMO[q] = true;
                goto next;
            }
            break;
            next:
        }
    }
    solve();
    reverse(r);
    solve();
    writeln(r.length);
    writeln(r.map!(i => (i+1).to!string).join(" "));
}