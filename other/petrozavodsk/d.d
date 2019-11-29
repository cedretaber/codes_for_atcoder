import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct UFTree(T)
{
    struct Node
    {
        T parent;
        T rank = 1;
    }

    ///
    this(T n)
    {
        nodes.length = n;
        sizes.length = n;
        foreach (i, ref node; nodes) {
            node = Node(i.to!T);
            sizes[i] = 1;
        }
    }

    ///
    bool unite(T a, T b)
    {
        a = root(a);
        b = root(b);

        if (a == b) return false;

        if (nodes[a].rank < nodes[b].rank) {
            sizes[nodes[a].parent] += sizes[nodes[b].parent];
            nodes[b].parent = nodes[a].parent;
        } else {
            sizes[nodes[b].parent] += sizes[nodes[a].parent];
            nodes[a].parent = nodes[b].parent;
            if (nodes[a].rank == nodes[b].rank) nodes[a].rank += 1;
        }

        return true;
    }

    ///
    bool is_same(T a, T b)
    {
        return root(a) == root(b);
    }

    ///
    T size(T i)
    {
        return sizes[root(i)];
    }

    T size()
    {
        bool[T] memo;
        foreach (node; this.nodes) {
            memo[root(node.parent)] = true;
        }
        T cnt;
        foreach (_; memo) ++cnt;
        return cnt;
    }

    Node[] nodes;
    T[] sizes;

    T root(T i)
    {
        if (nodes[i].parent == i) return i;

        return nodes[i].parent = root(nodes[i].parent);
    }
}

///
UFTree!T uftree(T)(T n)
{
    return UFTree!T(n);
}

alias Cost = Tuple!(int, "i", long, "a");
Cost[10^^5] CS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i, a; readln.split.to!(long[])) {
        CS[i] = Cost(i.to!int, a);
    }
    sort!"a.a < b.a"(CS[0..N]);

    auto uftree = uftree(N);

    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        uftree.unite(xy[0], xy[1]);
    }

    if (uftree.size() == 1) {
        writeln(0);
        return;
    }

    int[int] PS;
    foreach (node; uftree.nodes) {
        PS[uftree.root(node.parent)] = 0;
    }
    int max_n = -1;
    foreach (_; PS) ++max_n;

    int cnt;
    long r;
    foreach (ref c; CS[0..N]) {
        auto t = uftree.root(c.i);
        if (!PS[t]) {
            r += c.a;
            ++cnt;
            ++PS[t];
            c.a = -1;
        }
    }
    foreach (c; CS[0..N]) {
        if (cnt == max_n*2) break;
        auto t = uftree.root(c.i);
        if (c.a < 0) continue;
        ++cnt;
        r += c.a;
    }

    if (cnt == max_n*2) {
        writeln(r);
    } else {
        writeln("Impossible");
    }
}