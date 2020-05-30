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

    T root(T i)
    {
        if (nodes[i].parent == i) return i;

        return nodes[i].parent = root(nodes[i].parent);
    }

private:
    Node[] nodes;
    T[] sizes;
    T[] min_sizes;
}

///
UFTree!T uftree(T)(T n)
{
    return UFTree!T(n);
}

enum P = 10L^^9+7;

long pow(long x, long n) {
    long y = 1;
    while (n) {
        if (n%2 == 1) y = (y * x) % P;
        x = x^^2 % P;
        n /= 2;
    }
    return y;
}

void main()
{
    auto N = readln.chomp.to!int;
    auto uft = uftree(N);

    auto PS = readln.split.to!(int[]);
    long K;
    foreach (i, p; PS) {
        if (p == -1) {
            ++K;
        } else {
            uft.unite(i.to!int, p-1);
        }
    }
    int[int] C;
    int[] pc, lc;
    foreach (i; 0..N) {
        auto p = uft.root(i);
        if (p !in C) {
            C[p] = pc.length.to!int;
            pc ~= 0;
            lc ~= 0;
        }
        ++lc[C[p]];
        if (PS[i] == -1) {
            ++pc[C[p]];
        }
    }
    long r;
    foreach (l; lc) (r += l-1) %= P;
    (r *= pow(N-1, K)) %= P;
    foreach (i, l; lc) {
        foreach (j, m; lc) {
            if (i == j) continue;
        }
    }
}