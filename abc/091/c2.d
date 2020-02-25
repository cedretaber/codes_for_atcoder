import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct Graph(T)
{
    T L, R;
    T[][] adj;

    this(T L, T R)
    {
        this.L = L;
        this.R = R;
        adj.length = L + R;
    }

    void add_edge(T u, T v)
    {
        adj[u] ~= v+L;
        adj[v+L] ~= u;
    }

    T maximum_matching()
    {
        bool[] visited;
        T[] meta;
        visited.length = L;
        meta.length = L + R;
        meta[] = -1;

        bool augment(T u) {
            if (visited[u]) return false;
            visited[u] = true;
            foreach (w; adj[u]) {
                auto v = meta[w];
                if (v < 0 || augment(v)) {
                    meta[u] = w;
                    meta[w] = u;
                    return true;
                }
            }
            return false;
        }

        auto match = 0;
        foreach (u; 0..L) {
            visited[] = false;
            if (augment(u)) ++match;
        }
        return match;
    }
}

alias P = Tuple!(int, "x", int, "y");

void main()
{
    auto N = readln.chomp.to!int;
    P[] RS, BS;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        RS ~= P(ab[0], ab[1]);
    }
    foreach (_; 0..N) {
        auto cd = readln.split.to!(int[]);
        BS ~= P(cd[0], cd[1]);
    }

    auto G = Graph!int(N, N);

    foreach (i, b; BS) {
        foreach (j, r; RS) {
            if (r.x < b.x && r.y < b.y) {
                G.add_edge(i.to!int, j.to!int);
            }
        }
    }

    writeln(G.maximum_matching());
}