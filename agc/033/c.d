import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5*2] T;
bool[10^^5*2] FS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N-1) {
        auto ab = readln.split.to!(int[]);
        auto a = ab[0]-1;
        auto b = ab[1]-1;
        T[a] ~= b;
        T[b] ~= a;
    }

    alias EL = Tuple!(int, "e", int, "l");
    EL view(int i, int l) {
        auto el = EL(i, l+1);
        FS[i] = true;
        foreach (n; T[i]) {
            if (FS[n]) continue;
            auto nn = view(n, l+1);
            el = el.l > nn.l ? el : nn;
        }
        return el;
    }
    auto p1 = view(0, 0);
    FS[] = false;
    auto p2 = view(p1.e, 0);
    writeln(p2.l > 1 && (p2.l-2)%3 == 0 ? "Second" : "First");
}