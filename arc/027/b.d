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

int r(char c) {
    if ('0' <= c && c <= '9') {
        return c - '0';
    } else {
        return c - 'A' + 10;
    }
}

bool[36] FX;

void main()
{
    auto N = readln.chomp.to!int;
    auto s1 = readln.chomp.to!(char[]);
    auto s2 = readln.chomp.to!(char[]);

    auto uft = uftree!int(36);
    foreach (i; 0..N) {
        auto c1 = r(s1[i]);
        auto c2 = r(s2[i]);
        uft.unite(c1, c2);
    }
    long res = 1;
    foreach (i; 0..N) {
        auto c = r(s1[i]);
        if (c >= 10) {
            foreach (x; 10..36) if (FX[x]) {
                if (uft.is_same(c, x)) goto pass;
            }
            foreach (x; 0..10) {
                if (uft.is_same(c, x)) goto pass;
            }
            res *= 10 - (i == 0 ? 1 : 0);
            pass:
            FX[c] = true;
        }
    }
    writeln(res);
}