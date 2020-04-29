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

void main()
{
    auto N = readln.chomp.to!int;
    auto uft = uftree(26);
    int[26] bs;
    foreach (i; 0..N) {
        auto w = readln.chomp;
        auto h = w[0]-'a';
        auto t = w[$-1]-'a';
        uft.unite(h, t);
        ++bs[h];
        ++bs[t];
    }
    int v, f;
    foreach (i, b; bs) if (b) {
        f = i.to!int;
        ++v;
    }
    int r;
    while (uft.size(f) != v) {
        ++r;
        foreach (x; 0..26) if (bs[x] && !uft.is_same(f, x)) {
            int i = f, j = x;
            foreach (y; 0..26) if (uft.is_same(f, y) && bs[y]%2 == 1) {
                i = y;
                break;
            }
            foreach (y; 0..26) if (uft.is_same(x, y) && bs[y]%2 == 1) {
                j = y;
                break;
            }
            uft.unite(i, j);
            ++bs[i];
            ++bs[j];
            break;
        }
    }
    int rr;
    foreach (b; bs) if (b%2 == 1) ++rr;
    writeln(r + max(0, rr/2-1));
}