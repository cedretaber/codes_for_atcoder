import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

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
        sizes.length = n;
        foreach (i, ref node; nodes) {
            node = Node(i.to!T);
            sizes[i] = 1;
        }
    }

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

    T size(T i)
    {
        return sizes[root(i)];
    }

private:
    Node[] nodes;
    T[] sizes;

    T root(T i)
    {
        if (nodes[i].parent == i) return i;

        return nodes[i].parent = root(nodes[i].parent);
    }
}

alias AB = Tuple!(int, "a", int, "b");

AB[10^^5] ABS;
long[10^^5] RS;

void main()
{
    auto nm = readln.split.to!(long[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..M) {
        auto ab = readln.split.to!(int[]);
        ABS[i] = AB(ab[0] - 1, ab[1] - 1);
    }

    long fd = N * (N - 1) / 2;
    auto uft = UFTree!long(N.to!long);
    foreach_reverse (i; 0..M) {
        RS[i] = fd;

        auto ab = ABS[i];
        auto a = uft.size(ab.a);
        auto b = uft.size(ab.b);
        if (uft.unite(ab.a, ab.b)) {
            fd -= a * b;
        }
    }

    foreach (r; RS[0..M]) {
        writeln(r);
    }
}