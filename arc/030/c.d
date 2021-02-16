import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void get(Args...)(ref Args args)
{
    import std.traits, std.meta, std.typecons;

    static if (Args.length == 1) {
        alias Arg = Args[0];
        
        static if (isArray!Arg) {
          static if (isSomeChar!(ElementType!Arg)) {
            args[0] = readln.chomp.to!Arg;
          } else {
            args[0] = readln.split.to!Arg;
          }
        } else static if (isTuple!Arg) {
            auto input = readln.split;
            static foreach (i; 0..Fields!Arg.length) {
                args[0][i] = input[i].to!(Fields!Arg[i]);
            }
        } else {
            args[0] = readln.chomp.to!Arg;
        }
    } else {
        auto input = readln.split;
        assert(input.length == Args.length);

        static foreach (i; 0..Args.length) {
            args[i] = input[i].to!(Args[i]);
        }
    }
}

void get_lines(Args...)(size_t N, ref Args args)
{
    import std.traits, std.range;

    static foreach (i; 0..Args.length) {
        static assert(isArray!(Args[i]));
        args[i].length = N;
    }

    foreach (i; 0..N) {
        static if (Args.length == 1) {
            get(args[0][i]);
        } else {
            auto input = readln.split;
            static foreach (j; 0..Args.length) {
                args[j][i] = input[j].to!(ElementType!(Args[j]));
            }
        }
    }
}

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
    int N, M, K; get(N, M, K);
    auto cs = readln.split.map!(s => s[0].to!dchar).array();

    auto G1 = new int[][N];
    auto scc = SccGraph(N);
    while (M--) {
        int A, B; get(A, B); --A; --B;
        scc.addEdge(A, B);
        G1[A] ~= B; 
    }

    auto gs = scc.scc();
    auto e2g = new int[](N);
    auto css = new dchar[][gs.length];
    foreach (i, g; gs) {
        foreach (p; g) {
            e2g[p] = i.to!int;
            css[i] ~= cs[p];
        }
        sort(css[i]);
    }
    auto G = new int[][gs.length];
    foreach (i, g; gs) {
        bool[int] to;
        foreach (p; g) foreach (q; G1[p]) to[e2g[q]] = true;
        if (i.to!int in to) to.remove(i.to!int);
        foreach (k, _; to) G[i] ~= k;
    }
    auto len = gs.length.to!int;
    auto DP = new dchar[][][](len, K + 1, 0);
    foreach (ref dp1; DP) foreach (ref dp2; dp1) dp2 = "{".to!(dchar[]);
    foreach_reverse (i; 0..len) {
        foreach (l; 0..min(css[i].length, K) + 1) {
            auto C = css[i][0..l];
            if (l) DP[i][C.length] = min(DP[i][C.length], C);
            foreach (j; G[i]) foreach (ll, d; DP[j]) {
                if (l + ll > K) break;
                if (d.length == ll && d != "{") {
                    auto c = C ~ d;
                    DP[i][c.length] = min(DP[i][c.length], c);
                }
            }
        }
    }

    auto res = "{".to!(dchar[]);
    foreach (i; 0..len) res = min(res, DP[i][K]);
    if (res[0] == '{') {
        writeln(-1);
    } else {
        writeln(res);
    }
}