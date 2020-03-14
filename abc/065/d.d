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

alias T = Tuple!(int, "i", int, "p");
alias Path = Tuple!(long, "a", long, "b", long, "c");

void main()
{
    auto N = readln.chomp.to!int;
    T[] xs, ys;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(int[]);
        xs ~= T(i, xy[0]);
        ys ~= T(i, xy[1]);
    }
    sort!"a.p < b.p"(xs);
    sort!"a.p < b.p"(ys);

    Path[] ps;
    foreach (i; 0..N-1) {
        auto x1 = xs[i];
        auto x2 = xs[i+1];
        ps ~= Path(x1.i, x2.i, abs(x1.p - x2.p));
        auto y1 = ys[i];
        auto y2 = ys[i+1];
        ps ~= Path(y1.i, y2.i, abs(y1.p - y2.p));
    }
    sort!"a.c < b.c"(ps);

    auto uft = uftree!long(N);
    long cs;
    foreach (p; ps) {
        if (uft.is_same(p.a, p.b)) continue;
        uft.unite(p.a, p.b);
        cs += p.c;
    }
    writeln(cs);
}