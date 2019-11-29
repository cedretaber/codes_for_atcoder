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

    bool is_same(T a, T b)
    {
        return root(a) == root(b);
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

alias C = Tuple!(int, "n", long, "x", long, "y");
alias D = Tuple!(int, "a", int, "b", long, "d");

C[10^^5+1] CS;
D[10^^5+1] DSX, DSY;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(long[]);
        auto c = C(i, xy[0], xy[1]);
        CS[i] = c;
    }
    sort!"a.x < b.x"(CS[0..N]);
    foreach (i; 0..N-1) {
        auto a = CS[i];
        auto b = CS[i+1];
        DSX[i] = D(a.n, b.n, b.x - a.x);
    }
    sort!"a.y < b.y"(CS[0..N]);
    foreach (i; 0..N-1) {
        auto a = CS[i];
        auto b = CS[i+1];
        DSY[i] = D(a.n, b.n, b.y - a.y);
    }
    sort!"a.d < b.d"(DSX[0..N-1]);
    sort!"a.d < b.d"(DSY[0..N-1]);

    auto uft = UFTree!int(N);

    long r;
    for (size_t i, j; i != N-1 && j != N-1;) {
        auto a = long.max, b = long.max;
        if (i < N-1) a = DSX[i].d;
        if (j < N-1) b = DSY[j].d;
        D d;
        if (a < b) {
            d = DSX[i++];
        } else {
            d = DSY[j++];
        }
        if (uft.is_same(d.a, d.b)) continue;
        uft.unite(d.a, d.b);
        r += d.d;
    }

    writeln(r);
}