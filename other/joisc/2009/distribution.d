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

struct MCFGraph(Cap, Cost)
{
    import std.typecons : Tuple;

public:
    this(int n)
    {
        _n = n;
        g = new _edge[][](n);
    }

    int addEdge(int from, int to, Cap cap, Cost cost)
    {
        assert(0 <= from && from < _n);
        assert(0 <= to && to < _n);
        assert(0 <= cap);
        assert(0 <= cost);
        int m = cast(int) pos.length;
        pos ~= Tuple!(int, int)(from, cast(int) g[from].length);
        int from_id = cast(int) g[from].length;
        int to_id = cast(int) g[to].length;
        if (from == to)
            to_id++;
        g[from] ~= _edge(to, to_id, cap, cost);
        g[to] ~= _edge(from, from_id, 0, -cost);
        // g[from] ~= _edge(to, (cast(int) g[to].length), cap, cost);
        // g[to] ~= _edge(from, (cast(int) g[from].length) - 1, 0, -cost);
        return m;
    }

    struct Edge
    {
        int from, to;
        Cap cap, flow;
        Cost cost;
    }

    Edge getEdge(int i)
    {
        int m = cast(int) pos.length;
        assert(0 <= i && i < m);
        auto _e = g[pos[i][0]][pos[i][1]];
        auto _re = g[_e.to][_e.rev];
        return Edge(pos[i][0], _e.to, _e.cap + _re.cap, _re.cap, _e.cost);
    }

    Edge[] edges()
    {
        int m = cast(int) pos.length;
        auto result = new Edge[](m);
        foreach (i; 0 .. m)
            result[i] = getEdge(i);
        return result;
    }

    Tuple!(Cap, Cost) flow(int s, int t)
    {
        return flow(s, t, Cap.max);
    }

    Tuple!(Cap, Cost) flow(int s, int t, Cap flow_limit)
    {
        return slope(s, t, flow_limit)[$ - 1];
    }

    Tuple!(Cap, Cost)[] slope(int s, int t)
    {
        return slope(s, t, Cap.max);
    }

    Tuple!(Cap, Cost)[] slope(int s, int t, Cap flow_limit)
    {
        import std.container : Array, BinaryHeap;
        import std.algorithm : min;

        assert(0 <= s && s < _n);
        assert(0 <= t && t < _n);
        assert(s != t);
        auto dual = new Cost[](_n);
        auto dist = new Cost[](_n);
        auto pv = new int[](_n);
        auto pe = new int[](_n);
        auto vis = new bool[](_n);
        bool dualRef()
        {
            dist[] = Cost.max;
            pv[] = -1;
            pe[] = -1;
            vis[] = false;
            struct Q
            {
                Cost key;
                int to;
                int opCmp(const Q other) const
                {
                    if (key == other.key)
                        return 0;
                    return key > other.key ? -1 : 1;
                }
            }

            BinaryHeap!(Array!Q) que;
            dist[s] = 0;
            que.insert(Q(0, s));
            while (!que.empty)
            {
                int v = que.front.to;
                que.removeFront();
                if (vis[v])
                    continue;
                vis[v] = true;
                if (v == t)
                    break;
                foreach (i; 0 .. cast(int) g[v].length)
                {
                    auto e = g[v][i];
                    if (vis[e.to] || !e.cap)
                        continue;
                    Cost cost = e.cost - dual[e.to] + dual[v];
                    if (dist[e.to] - dist[v] > cost)
                    {
                        dist[e.to] = dist[v] + cost;
                        pv[e.to] = v;
                        pe[e.to] = i;
                        que.insert(Q(dist[e.to], e.to));
                    }
                }
            }
            if (!vis[t])
                return false;
            foreach (v; 0 .. _n)
            {
                if (!vis[v])
                    continue;
                dual[v] -= dist[t] - dist[v];
            }
            return true;
        }

        Cap flow = 0;
        Cost cost = 0, prev_cost_per_flow = -1;
        Tuple!(Cap, Cost)[] result;
        result ~= Tuple!(Cap, Cost)(flow, cost);
        while (flow < flow_limit)
        {
            if (!dualRef())
                break;
            Cap c = flow_limit - flow;
            for (int v = t; v != s; v = pv[v])
                c = min(c, g[pv[v]][pe[v]].cap);
            for (int v = t; v != s; v = pv[v])
            {
                g[pv[v]][pe[v]].cap -= c;
                g[v][g[pv[v]][pe[v]].rev].cap += c;
            }
            Cost d = -dual[s];
            flow += c;
            cost += c * d;
            if (prev_cost_per_flow == d)
                result.length--;
            result ~= Tuple!(Cap, Cost)(flow, cost);
            prev_cost_per_flow = d;
        }
        return result;
    }

private:
    int _n;
    struct _edge
    {
        int to, rev;
        Cap cap;
        Cost cost;
    }

    Tuple!(int, int)[] pos;
    _edge[][] g;
}

enum MAX_A = 10000;

void main()
{
    int N, M; get(N, M);
    auto G = MCFGraph!(int, int)(N+2);
    auto cs = new int[](N+1);
    auto T = new int[][N+1];
    foreach (i; 1..N+1) {
        int s, a; get(s, a);
        G.addEdge(s, i, 1, MAX_A - a);
        G.addEdge(s, i, M, MAX_A);
        cs[s] += 1;
        T[s] ~= i;
    }
    auto ds = new int[](N+1);
    void walk(int i, int d) {
        ds[i] = d;
        foreach (j; T[i]) walk(j, d+1);
    }
    walk(1, 0);
    auto max_d = ds.maxElement();
    foreach (i; 1..N+1) if (cs[i] == 0) G.addEdge(i, N+1, M, (max_d - ds[i]) * MAX_A);
    writeln((max_d + 1) * MAX_A * M - G.flow(0, N+1, M)[1]);
}

/*

n=7 m=4
     1
   1  10
   1  10
   20 10

     1
  10   10
   1   10
   1    1
  20    1

   1
 1   1
1 1 1  1

3 3 3 3
1 0 3 3
1 0 1 0
0 0 1 0
*/