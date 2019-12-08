import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

struct UFTree(T)
{
    struct Node
    {
        T parent;
        T rank = 1;
    }

    ///
    T min_size, max_size;

    ///
    this(T n)
    {
        nodes.length = n;
        sizes.length = n;
        foreach (i, ref node; nodes) {
            node = Node(i.to!T);
            sizes[i] = 1;
        }

        min_sizes.length = n + 1;
        min_sizes[1] = n;
        min_size = 1;
        max_size = 1;
    }

    ///
    bool unite(T a, T b)
    {
        a = root(a);
        b = root(b);

        if (a == b) return false;

        auto a_size = sizes[a];
        auto b_size = sizes[b];
        --min_sizes[a_size];
        --min_sizes[b_size];
        ++min_sizes[a_size + b_size];
        foreach (nxt_size; min(a_size, b_size)..min_sizes.length) if (min_sizes[nxt_size] != 0) {
            min_size = nxt_size.to!T;
            break;
        }
        max_size = max(max_size, a_size + b_size);

        if (nodes[a].rank < nodes[b].rank) {
            sizes[a] += sizes[b];
            nodes[b].parent = a;
        } else {
            sizes[b] += sizes[a];
            nodes[a].parent = b;
            if (nodes[a].rank == nodes[b].rank) ++nodes[b].rank;
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

private:
    Node[] nodes;
    T[] sizes;
    T[] min_sizes;

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

alias Path = Tuple!(int, "a", int, "b", long, "c");

void main()
{
    auto nmq = readln.split.to!(int[]);
    auto N = nmq[0];
    auto M = nmq[1];
    auto Q = nmq[2];
    auto ps = new Path[](M);
    foreach (i; 0..M) {
        auto abc = readln.split;
        ps[i] = Path(abc[0].to!int-1, abc[1].to!int-1, abc[2].to!long);
    }
    sort!"a.c < b.c"(ps);
    auto uft = uftree(N);
    auto sizes = new long[](N+1);
    sizes[] = -1;
    sizes[1] = 0;
    int i, j = 1;
    while (i < M && j < N) {
        auto c = ps[i].c;
        while (i < M && ps[i].c == c) {
            uft.unite(ps[i].a, ps[i].b);
            ++i;
        }
        foreach (k; j..uft.min_size) sizes[k+1] = c;
        j = uft.min_size;
    }

    foreach (_; 0..Q) {
        auto q = readln.chomp.to!int;
        if (q >= sizes.length || sizes[q] == -1) {
            writeln("trumpet");
        } else {
            writeln(sizes[q]);
        }
    }
}