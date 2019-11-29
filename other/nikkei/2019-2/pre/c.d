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

private:
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

alias AB = Tuple!(int, "a", int, "b");

void main()
{
    auto N = readln.chomp.to!int;
    auto ab = new AB[](N);
    auto as = new int[](N);
    foreach (i, a; readln.split.to!(int[])) {
        ab[i].a = a;
        as[i] = a;
    }
    foreach (i, b; readln.split.to!(int[])) ab[i].b = b;
    sort!"a.b < b.b"(ab);
    sort(as);
    foreach (i; 0..N) {
        if (as[i] > ab[i].b) {
            writeln("No");
            return;
        }
    }
    AB[] xas, yas;
    xas.length = N;
    yas.length = N;
    foreach (i; 0..N) {
        xas[i] = AB(i, ab[i].a);
        yas[i] = AB(i, ab[i].a);
    }
    sort!"a.b < b.b"(yas);
    auto uft = uftree(N);
    foreach (i; 0..N) {
        uft.unite(xas[i].a, yas[i].a);
    }
    if (uft.size(0) != N) {
        writeln("Yes");
        return;
    }
    foreach (i; 0..N-1) {
        if (as[i+1] <= ab[i].b) {
            writeln("Yes");
            return;
        }
    }
    writeln("No");
}