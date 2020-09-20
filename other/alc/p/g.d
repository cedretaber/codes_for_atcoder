import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

struct CompressedSparseRow(E)
{
    import std.typecons : Tuple;

    int[] start;
    E[] elist;
    this(int n, const ref Tuple!(int, E)[] edges)
    {
        start = new typeof(start)(n + 1);
        elist = new typeof(elist)(edges.length);
        foreach (e; edges)
            start[e[0] + 1]++;
        foreach (i; 0 .. n)
            start[i + 1] += start[i];
        auto counter = start.dup;
        foreach (e; edges)
            elist[counter[e[0]]++] = e[1];
    }
}

struct SccGraphImpl
{
    import std.typecons : Tuple;
    import std.algorithm : min;

public:
    this(int n)
    {
        _n = n;
    }

    int numVerticles()
    {
        return _n;
    }

    void addEdge(int from, int to)
    {
        edges ~= Tuple!(int, edge)(from, edge(to));
    }

    Tuple!(int, int[]) sccIds()
    {
        auto g = CompressedSparseRow!(edge)(_n, edges);
        int now_ord = 0, group_num = 0;
        int[] visited;
        auto low = new int[](_n);
        auto ord = new int[](_n);
        ord[] = -1;
        auto ids = new int[](_n);
        visited.reserve(_n);
        void dfs(int v)
        {
            low[v] = ord[v] = now_ord++;
            visited ~= v;
            foreach (i; g.start[v] .. g.start[v + 1])
            {
                auto to = g.elist[i].to;
                if (ord[to] == -1)
                {
                    dfs(to);
                    low[v] = min(low[v], low[to]);
                }
                else
                {
                    low[v] = min(low[v], ord[to]);
                }
            }
            if (low[v] == ord[v])
            {
                while (true)
                {
                    int u = visited[$ - 1];
                    visited.length--;
                    ord[u] = _n;
                    ids[u] = group_num;
                    if (u == v)
                        break;
                }
                group_num++;
            }
        }

        foreach (i; 0 .. _n)
            if (ord[i] == -1)
                dfs(i);
        foreach (ref x; ids)
            x = group_num - 1 - x;
        return Tuple!(int, int[])(group_num, ids);
    }

    int[][] scc()
    {
        auto ids = sccIds();
        int group_num = ids[0];
        auto counts = new int[](group_num);
        foreach (x; ids[1])
            counts[x]++;
        auto groups = new int[][](ids[0]);
        foreach (i; 0 .. group_num)
            groups[i].reserve(counts[i]);
        foreach (i; 0 .. _n)
            groups[ids[1][i]] ~= i;
        return groups;
    }

private:
    int _n;
    struct edge
    {
        int to;
    }

    Tuple!(int, edge)[] edges;
}

struct SccGraph
{
    this(int n)
    {
        internal = SccGraphImpl(n);
    }

    void addEdge(int from, int to)
    {
        int n = internal.numVerticles();
        assert(0 <= from && from < n);
        assert(0 <= to && to < n);
        internal.addEdge(from, to);
    }

    int[][] scc()
    {
        return internal.scc();
    }

private:
    SccGraphImpl internal;
}

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto G = SccGraph(N);
    while (M--) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0];
        auto b = ab[1];
        G.addEdge(a, b);
    }

    auto scc = G.scc();
    writeln(scc.length);
    foreach (ls; scc) {
        writeln(ls.length, " ", ls.to!(string[]).join(" "));
    }
}