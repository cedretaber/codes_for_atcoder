import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

alias Edge = Tuple!(int, "to", int, "weight");

Edge[][10 ^^ 5 + 1] ES;
long[10 ^^ 5 + 1] LS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N - 1) {
        auto e = readln.split.to!(int[]);
        ES[e[0]] ~= Edge(e[1], e[2]);
        ES[e[1]] ~= Edge(e[0], e[2]);
    }

    auto qk = readln.split.to!(int[]);
    auto Q = qk[0];
    auto K = qk[1];
    
    auto roots = [K];
    LS[K] = 0;

    while (!roots.empty) {
        int[] nexts;
        foreach (r; roots) {
            foreach (e; ES[r]) {
                auto l = e.weight + LS[r];
                if (e.to == K || (LS[e.to] != 0)) continue;
                LS[e.to] = l;
                nexts ~= e.to;
            }
        }
        roots = nexts;
    }

    foreach (_; 0..Q) {
        auto xy = readln.split.to!(int[]);
        writeln(LS[xy[0]] + LS[xy[1]]);
    }
}