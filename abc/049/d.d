import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

struct UnionFind
{

    struct Node
    {
        size_t parent;
        int rank;

        this(size_t n) {
            parent = n;
            rank = 1;
        }
    }

    Node[] nodes;

    this(size_t n) {
        nodes.length = n;
        foreach (i; 0..n) {
            nodes[i] = Node(i);
        }
    }

    void unite(size_t a, size_t b) {
        a = root(a);
        b = root(b);
        if (a == b) return;

        if (nodes[a].rank < nodes[b].rank) {
            nodes[a].parent = b;
        } else {
            nodes[b].parent = a;
            if (nodes[a].rank == nodes[b].rank) nodes[b].rank += 1;
        }
    }

    bool is_same_root(size_t a, size_t b) {
        return root(a) == root(b);
    }

    size_t root(size_t i) {
        if (nodes[i].parent == i) return nodes[i].parent;
        return nodes[i].parent = root(nodes[i].parent);
    }
}

void main()
{
    auto nkl = readln.split.to!(int[]);
    auto N = nkl[0];
    auto K = nkl[1];
    auto L = nkl[2];

    auto roads = UnionFind(N);
    auto rails = UnionFind(N);

    foreach (_; 0..K) {
        auto pq = readln.split.to!(int[]);
        roads.unite(pq[0]-1, pq[1]-1);
    }
    foreach (_; 0..L) {
        auto rs = readln.split.to!(int[]);
        rails.unite(rs[0]-1, rs[1]-1);
    }

    int[string] cnt;
    string[] ks;
    ks.length = N;
    foreach (i; 0..N) {
        auto rd = roads.root(i);
        auto rl = rails.root(i);
        auto key = rd.to!string ~ "*" ~ rl.to!string;
        ks[i] = key;
        if (key !in cnt) cnt[key] = 0;
        ++cnt[key];
    }

    foreach (ref k; ks) {
        k = cnt[k].to!string;
    }
    writeln(ks.join(" "));
}