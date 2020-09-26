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

struct TwoSat
{
public:
    this(int n)
    {
        _n = n;
        _answer = new bool[](n);
        scc = SccGraphImpl(2 * n + 2);
    }

    void addClause(int i, bool f, int j, bool g)
    {
        assert(0 <= i && i < _n);
        assert(0 <= j && j < _n);
        scc.addEdge(2 * i + (f ? 0 : 1), 2 * j + (g ? 1 : 0));
        scc.addEdge(2 * j + (g ? 0 : 1), 2 * i + (f ? 1 : 0));
    }

    bool satisfiable()
    {
        auto id = scc.sccIds()[1];
        foreach (i; 0 .. _n)
        {
            if (id[2 * i] == id[2 * i + 1])
                return false;
            _answer[i] = id[2 * i] < id[2 * i + 1];
        }
        return true;
    }

    bool[] answer()
    {
        return _answer;
    }

private:
    int _n;
    bool[] _answer;
    SccGraphImpl scc;
}

void main()
{
    auto nd = readln.split.to!(int[]);
    auto N = nd[0];
    auto D = nd[1];

    auto sat = TwoSat(N*2);

    int[] xs, ys;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(int[]);
        auto x = xy[0];
        auto y = xy[1];
        xs ~= x;
        ys ~= y;

        sat.addClause(i, true, N+i, true);
    }

    foreach (i; 0..N) foreach (j; 0..N) if (i != j) {
        if (abs(xs[i] - xs[j]) < D) sat.addClause(i, false, j, false);
        if (abs(xs[i] - ys[j]) < D) sat.addClause(i, false, N+j, false);
        if (abs(ys[i] - xs[j]) < D) sat.addClause(N+i, false, j, false);
        if (abs(ys[i] - ys[j]) < D) sat.addClause(N+i, false, N+j, false);
    }

    if (sat.satisfiable()) {
        writeln("Yes");
        auto res = new int[](N);
        foreach (i, a; sat.answer()) if (a) {
            if (i < N) {
                res[i] = xs[i];
            } else {
                res[i-N] = ys[i-N];
            }
        }
        res.each!writeln;
    } else {
        writeln("No");
    }
}