import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

struct MFGraph(Cap)
{
    import std.typecons : Tuple;

public:
    this(int n)
    {
        _n = n;
        g = new _edge[][](n);
    }

    int addEdge(int from, int to, Cap cap)
    {
        assert(0 <= from && from < _n);
        assert(0 <= to && to < _n);
        assert(0 <= cap);
        int m = cast(int) pos.length;
        pos ~= Tuple!(int, int)(from, cast(int)(g[from].length));
        g[from] ~= _edge(to, cast(int)(g[to].length), cap);
        g[to] ~= _edge(from, cast(int)(g[from].length) - 1, 0);
        return m;
    }

    struct edge
    {
        int from, to;
        Cap cap, flow;
    }

    edge getEdge(int i)
    {
        int m = cast(int)(pos.length);
        assert(0 <= i && i < m);
        auto _e = g[pos[i][0]][pos[i][1]];
        auto _re = g[_e.to][_e.rev];
        return edge(pos[i][0], _e.to, _e.cap + _re.cap, _re.cap);
    }

    edge[] edges()
    {
        int m = cast(int)(pos.length);
        edge[] result;
        foreach (i; 0 .. m)
            result ~= getEdge(i);
        return result;
    }

    void changeEdge(int i, Cap new_cap, Cap new_flow)
    {
        int m = cast(int)(pos.length);
        assert(0 <= i && i < m);
        assert(0 <= new_flow && new_flow <= new_cap);
        auto _e = &g[pos[i][0]][pos[i][1]];
        auto _re = &g[_e.to][_e.rev];
        _e.cap = new_cap - new_flow;
        _re.cap = new_flow;
    }

    Cap flow(int s, int t)
    {
        return flow(s, t, Cap.max);
    }

    Cap flow(int s, int t, Cap flow_limit)
    {
        import std.container : DList;
        import std.algorithm : min;

        assert(0 <= s && s < _n);
        assert(0 <= t && t < _n);

        auto level = new int[](_n), iter = new int[](_n);
        DList!int que;

        void bfs()
        {
            level[] = -1;
            level[s] = 0;
            que.clear();
            que.insertBack(s);
            while (!que.empty)
            {
                int v = que.front;
                que.removeFront();
                foreach (e; g[v])
                {
                    if (e.cap == 0 || level[e.to] >= 0)
                        continue;
                    level[e.to] = level[v] + 1;
                    if (e.to == t)
                        return;
                    que.insertBack(e.to);
                }
            }
        }

        Cap dfs(int v, Cap up)
        {
            if (v == s)
                return up;
            Cap res = 0;
            int level_v = level[v];
            for (; iter[v] < cast(int)(g[v].length); iter[v]++)
            {
                auto i = iter[v];
                auto e = g[v][i];
                if (level_v <= level[e.to] || g[e.to][e.rev].cap == 0)
                    continue;
                Cap d = dfs(e.to, min(up - res, g[e.to][e.rev].cap));
                if (d <= 0)
                    continue;
                g[v][i].cap += d;
                g[e.to][e.rev].cap -= d;
                res += d;
                if (res == up)
                    break;
            }
            return res;
        }

        Cap flow = 0;
        while (flow < flow_limit)
        {
            bfs();
            if (level[t] == -1)
                break;
            iter[] = 0;
            while (flow < flow_limit)
            {
                Cap f = dfs(t, flow_limit - flow);
                if (!f)
                    break;
                flow += f;
            }
        }
        return flow;
    }

    bool[] minCut(int s)
    {
        import std.container : DList;

        auto visited = new bool[](_n);
        DList!int que;
        que.insertBack(s);
        while (!que.empty)
        {
            int p = que.front;
            que.removeFront();
            visited[p] = true;
            foreach (e; g[p])
            {
                if (e.cap && !visited[e.to])
                {
                    visited[e.to] = true;
                    que.insertBack(e.to);
                }
            }
        }
        return visited;
    }

private:
    struct _edge
    {
        int to, rev;
        Cap cap;
    }

    int _n;
    Tuple!(int, int)[] pos;
    _edge[][] g;
}

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    char[][] MAP;
    foreach (_; 0..N) MAP ~= readln.chomp.to!(char[]);

    auto G = MFGraph!int(N*M+2);
    auto s = N*M, t = N*M+1;
    foreach (i; 0..N) foreach (j; 0..M) {
        if (MAP[i][j] == '#') continue;
        auto v = i*M+j;
        if ((i+j)%2 == 0) {
            G.addEdge(s, v, 1);
            static foreach (d; [[1,0], [0,1], [-1,0], [0,-1]]) {{
                auto ii = i+d[0];
                auto jj = j+d[1];
                if (0 <= ii && ii < N && 0 <= jj && jj < M && MAP[ii][jj] == '.') {
                    G.addEdge(v, ii*M+jj, 1);
                }
            }}
        } else {
            G.addEdge(v, t, 1);
        }
    }

    writeln(G.flow(s, t));
    foreach (e; G.edges()) {
        if (e.from == s || e.to == t || e.flow == 0) continue;
        auto i0 = e.from/M, j0 = e.from%M;
        auto i1 = e.to/M, j1 = e.to%M;
        if (i0+1 == i1) {
            MAP[i0][j0] = 'v';
            MAP[i1][j1] = '^';
        } else if (i0-1 == i1) {
            MAP[i0][j0] = '^';
            MAP[i1][j1] = 'v';
        } else if (j0+1 == j1) {
            MAP[i0][j0] = '>';
            MAP[i1][j1] = '<';
        } else {
            MAP[i0][j0] = '<';
            MAP[i1][j1] = '>';
        }
    }
    foreach (line; MAP) writeln(line);
}