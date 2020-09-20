import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

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

alias P = Tuple!(int, "i", int, "x", int, "y");

void main()
{
    auto N = readln.chomp.to!int;
    P[] ps;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(int[]);
        ps ~= P(i, xy[0], xy[1]);
    }
    sort!"a.x < b.x"(ps);
    auto y2i = new int[](N+1);
    foreach (i, p; ps) y2i[p.y] = i.to!int;

    auto max_y = ps.map!(p => p.y).array;
    foreach_reverse (i; 0..N-1) max_y[i] = max(max_y[i], max_y[i+1]);

    auto memo = new bool[](N);
    auto uft = uftree!int(N);
    foreach (y; 1..N+1) {
        auto i = y2i[y];
        auto p = ps[i];
        if (memo[i]) continue;
        memo[i] = true;

        int j = i+1;
        while (j < N) {
            if (memo[j]) break;
            memo[j] = true;
            uft.unite(p.i, ps[j].i);
            ++j;
        }
        if (j < N && memo[j]) {
            if (max_y[j] > y) uft.unite(ps[j-1].i, ps[j].i);
        }
    }
    foreach (i; 0..N) writeln(uft.size(i));
}

/*

4
1 4
2 3
3 1
4 2

7
6 4
4 3
3 5
7 1
2 7
5 2
1 6

7
1 6
2 7
3 5
4 3
5 2
6 4
7 1

7
1 7
2 1
3 6
4 3
5 5
6 2
7 4
 
1 1
2 2
3 3
4 4
5 5
6 6
7 7

1
6
6
6
6
6
6

*/