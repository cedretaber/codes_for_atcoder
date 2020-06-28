import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

void main()
{
    auto N = readln.chomp.to!int;
    auto T = new int[][N];
    foreach (_; 1..N) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }
    int p1, max_l;
    void run1(int i, int p, int l) {
        if (max_l < l) {
            max_l = l;
            p1 = i;
        }
        foreach (j; T[i]) if (j != p) run1(j, i, l+1);
    }
    run1(0, -1, 0);
    int run2(int i, int p, int l) {
        int ll = l;
        foreach (j; T[i]) if (j != p) ll = max(ll, run2(j, i, l+1));
        return ll;
    }
    auto len = run2(p1, -1, 1);
    writeln((len-2)%3 == 0 ? "Second" : "First");
}