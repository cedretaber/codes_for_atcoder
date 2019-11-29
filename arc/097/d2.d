import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math;

struct UFTree(T)
{
    struct Node
    {
        T parent;
        T rank = 1;
    }

    this(T n)
    {
        nodes.length = n;
        foreach (i, ref node; nodes) node = Node(i.to!T);
    }

    void unite(T a, T b)
    {
        a = root(a);
        b = root(b);

        if (a == b) return;

        if (nodes[a].rank < nodes[b].rank) {
            nodes[b].parent = nodes[a].parent;
        } else {
            nodes[a].parent = nodes[b].parent;
            if (nodes[a].rank == nodes[b].rank) nodes[a].rank += 1;
        }
    }

    bool is_same(T a, T b)
    {
        return root(a) == root(b);
    }

private:
    Node[] nodes;

    T root(T i)
    {
        if (nodes[i].parent == i) return i;

        return nodes[i].parent = root(nodes[i].parent);
    }
}

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    auto PS = readln.split.to!(int[]);

    auto uft = UFTree!int(N+1);
    foreach (_; 0..M) {
        auto xy = readln.split.to!(int[]);
        uft.unite(xy[0], xy[1]);
    }

    int res;
    foreach (int i, p; PS) {
        if (uft.is_same(i+1, p)) ++res;
    }

    writeln(res);
}