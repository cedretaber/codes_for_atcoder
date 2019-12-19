import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

class Node {
    char c;
    Node[char] cs;
    int[] ns;

    this(char c) {
        this.c = c;
    }
}

void main()
{
    auto nk = readln.split.to!(int[]);
    auto N = nk[0];
    auto K = nk[1];
    auto as = readln.split.to!(int[]);

    if (as.length == N) {
        writeln("");
        return;
    }
    sort(as);

    auto TREE = new Node('*');
    char[] targ;
    foreach (i; 1..N+1) {
        auto s = readln.chomp.to!(char[]);
        if (i == as[0]) targ = s;
        auto t = TREE;
        foreach (c; s) {
            if (c in t.cs) {
                t = t.cs[c];
                t.ns ~= i;
            } else {
                auto at = new Node(c);
                at.ns ~= i;
                t.cs[c] = at;
                t = at;
            }
        }
    }

    auto t = TREE;
    char[] r;
    foreach (c; targ) {
        auto n = t.cs[c];
        r ~= n.c;
        if (n.ns == as) {
            writeln(r);
            return;
        } else if (n.ns.length <= as.length) {
            writeln(-1);
            return;
        }
        t = n;
    }
    writeln(-1);
}