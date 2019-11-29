import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.range;

alias Point = Tuple!(int, "x", int, "y");

int N;
Point[100] RS, BS;
int[][200] GS;

void main()
{
    N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto ab = readln.split.to!(int[]);
        RS[i] = Point(ab[0], ab[1], 0);
    }
    foreach (i; 0..N) {
        auto cd = readln.split.to!(int[]);
        BS[i] = Point(cd[0], cd[1], 0);
    }

    foreach (int i, r; RS[0..N]) {
        foreach (int j, b; BS[0..N]) {
            if (r.x < b.x && r.y < b.y) {
                GS[i] ~= 100+j;
                GS[100+j] ~= i;
            }
        }
    }

    int res;
    int[200] match = -1;
    foreach (i; 0..200) {
        if (match[i] < 0) {
            bool[200] used;
            bool search(int p) {
                used[p] = true;
                foreach (g; GS[p]) {
                    auto s = match[g];
                    if (s < 0 || !used[s] && search(s)) {
                        match[p] = g;
                        match[g] = p;
                        return true;
                    }
                }
                return false;
            }
            if (search(i)) ++res;
        }
    }
    writeln(res);
}