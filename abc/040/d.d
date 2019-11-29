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

alias R = Tuple!(int, "a", int, "b", int, "y");
alias P = Tuple!(int, "j", int, "v", int, "w");

R[200000] RS;
P[100000] PS;
int[100000] SS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..M) {
        auto aby = readln.split.to!(int[]);
        RS[i] = R(aby[0] - 1, aby[1] - 1, aby[2]);
    }
    sort!"a.y > b.y"(RS[0..M]);
    
    auto Q = readln.chomp.to!int;
    foreach (j; 0..Q) {
        auto vw = readln.split.to!(int[]);
        PS[j] = P(j, vw[0] - 1, vw[1]);
    }
    sort!"a.w > b.w"(PS[0..Q]);

    auto uft = UFTree!int(N);
    int i;
    foreach (p; PS[0..Q]) {
        while (i < M && RS[i].y > p.w) {
            uft.unite(RS[i].a, RS[i].b);
            ++i;
        }
        SS[p.j] = uft.size(p.v);
    }

    foreach (s; SS[0..Q]) writeln(s);
}