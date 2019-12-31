import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.ascii, core.bitop;

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

alias T = Tuple!(double, "x", double, "y", int, "c");
alias P = Tuple!(int, "a", int, "b", double, "c");

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    T[] BT, ST;
    foreach (_; 0..N) {
        auto xyz = readln.split.to!(int[]);
        BT ~= T(xyz[0].to!double, xyz[1].to!double, xyz[2]);
    }
    foreach (_; 0..M) {
        auto xyz = readln.split.to!(int[]);
        ST ~= T(xyz[0].to!double, xyz[1].to!double, xyz[2]);
    }

    double r = 1.0/0;
    foreach (uint st; 0..(1<<M)) {
        P[] ps;
        foreach (i; 0..N) {
            foreach (j; i+1..N) {
                auto c = sqrt((BT[i].x - BT[j].x)^^2 + (BT[i].y - BT[j].y)^^2);
                if (BT[i].c != BT[j].c) c *= 10;
                ps ~= P(i, j, c);
            }
            int k = N;
            foreach (j; 0..M) if (st & (1<<j)) {
                auto c = sqrt((BT[i].x - ST[j].x)^^2 + (BT[i].y - ST[j].y)^^2);
                if (BT[i].c != ST[j].c) c *= 10;
                ps ~= P(i, k++, c);
            }
        }
        int u = N;
        foreach (i; 0..M) if (st & (1<<i)) {
            int v = u;
            foreach (j; i+1..M) if (st & (1<<j)) {
                auto c = sqrt((ST[i].x - ST[j].x)^^2 + (ST[i].y - ST[j].y)^^2);
                if (ST[i].c != ST[j].c) c *= 10;
                ps ~= P(u, ++v, c);
            }
            ++u;
        }
        sort!"a.c < b.c"(ps);

        auto uft = uftree(N + popcnt(st));
        double rr = 0;
        foreach (p; ps) {
            if (uft.is_same(p.a, p.b)) continue;
            uft.unite(p.a, p.b);
            rr += p.c;
        }
        r = min(r, rr);
    }

    writefln("%.10f", r);
}