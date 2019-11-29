import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.bigint;

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

bool[10^^5] MEMO;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto uft = uftree(N);
    foreach (_; 0..M) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        uft.unite(a, b);
    }

    int c;
    foreach (i; 0..N) {
        auto r = uft.root(i);
        if (!MEMO[r]) {
            MEMO[r] = true;
            ++c;
        }
    }
    writeln(c-1);
}