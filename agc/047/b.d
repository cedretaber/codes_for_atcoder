import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

class Tree
{
    Tree[26] children;
    long[26] counts;
    char c;

    this(char c) {
        this.c = c;
    }

    void add(string s) {
        assert(this.c == '\n');

        auto last = s[$-1];
        if (children[last - 'a'] is null) {
            children[last - 'a'] = new Tree(last);
        }
        long[26] cs;
        children[last - 'a'].add(s[0..$-1], cs);
        foreach (i, c; cs) this.counts[i] += c;
    }

    void add(string s, ref long[26] cs) {
        if (s.empty) {
            ++cs[this.c - 'a'];
            return;
        }

        auto last = s[$-1];
        if (children[last - 'a'] is null) {
            children[last - 'a'] = new Tree(last);
        }
        children[last - 'a'].add(s[0..$-1], cs);

        foreach (i, c; cs) this.counts[i] += c;
        cs[this.c - 'a'] = 1;
    }

    long count(string s) {
        if (s[$-1] == '\n') s = s[0..$-1];

        auto c = s[$-1];
        if (s.length == 1) {
            return this.counts[c - 'a'] - 1;
        } else {
            return this.children[c - 'a'].count(s[0..$-1]);
        }
    }
}

void main()
{
    auto N = readln.chomp.to!int;
    auto tree = new Tree('\n');
    string[] ss;
    foreach (_; 0..N) {
        auto s = readln.chomp;
        tree.add(s);
        ss ~= s;
    }
    long r;
    foreach (s; ss) r += tree.count(s);
    writeln(r);
}