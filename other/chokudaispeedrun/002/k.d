import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5*4] G;
bool[10^^5*4] MEMO;

void main()
{
    auto N = readln.chomp.to!int;
    int[int] TO;
    int rep;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        if (ab[0] !in TO) TO[ab[0]] = rep++;
        if (ab[1] !in TO) TO[ab[1]] = rep++;
        auto A = TO[ab[0]];
        auto B = TO[ab[1]];
        G[A] ~= B;
        G[B] ~= A;
    }

    int node, edge;
    void count(int i, int prev) {
        if (MEMO[i]) return;
        MEMO[i] = true;
        ++node;
        foreach (next; G[i]) {
            if (next == prev) continue;
            ++edge;
            count(next, i);
        }
    }

    int r;
    foreach (i; 0..rep) {
        if (MEMO[i]) continue;
        node = edge = 0;
        count(i, -1);
        r += min(node, edge);
    }
    writeln(r);
}