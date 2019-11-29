import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

struct Graph
{
    int L, R;
    int[][] adj;

    this(int L, int R) {
        this.L = L;
        this.R = R;
        adj.length = L + R;
    }

    void add_edge(int u, int v) {
        adj[u] ~= v+L;
        adj[v+L] ~= u;
    }

    int maximum_matching() {
        int[] visited, meta;
        visited.length = L;
        meta.length = L + R;
        meta[] = -1;

        bool augument(int u) {
            if (visited[u]) return false;
            visited[u] = true;
            foreach (w; adj[u]) {
                auto v = meta[w];
                if (v <0 || augument(v)) {
                    meta[u] = w;
                    meta[w] = u;
                    return true;
                }
            }
            return false;
        }

        auto match = 0;
        foreach (u; 0..L) {
            visited[] = 0;
            if (augument(u)) ++match;
        }
        return match;
    }
}

int[40][40] TON;

void main()
{
    auto rc = readln.split.to!(int[]);
    auto r = rc[0];
    auto c = rc[1];

    wchar[][] map;
    map.length = r;
    foreach (i; 0..r)
        map[i] = readln.chomp.to!(wchar[]);
    
    int L, R;
    foreach (int y, row; map) {
        foreach (int x, p; row) {
            if (map[y][x] == '*') continue;
            if ((x+y)&1) {
                TON[y][x] = L++;
            } else {
                TON[y][x] = R++;
            }
        }
    }

    auto graph = Graph(L, R);
    foreach (int y, row; map) {
        foreach (int x, p; row) {
            if (map[y][x] == '*') continue;
            if ((x+y)&1) {
                if (x > 0 && map[y][x-1] == '.') graph.add_edge(TON[y][x], TON[y][x-1]);
                if (x < c-1 && map[y][x+1] == '.') graph.add_edge(TON[y][x], TON[y][x+1]);
                if (y > 0 && map[y-1][x] == '.') graph.add_edge(TON[y][x], TON[y-1][x]);
                if (y < r-1 && map[y+1][x] == '.') graph.add_edge(TON[y][x], TON[y+1][x]);
            } else {
                if (x > 0 && map[y][x-1] == '.') graph.add_edge(TON[y][x-1], TON[y][x]);
                if (x < c-1 && map[y][x+1] == '.') graph.add_edge(TON[y][x+1], TON[y][x]);
                if (y > 0 && map[y-1][x] == '.') graph.add_edge(TON[y-1][x], TON[y][x]);
                if (y < r-1 && map[y+1][x] == '.') graph.add_edge(TON[y+1][x], TON[y][x]);
            }
        }
    }
    writeln((L+R - graph.maximum_matching()).abs);
}