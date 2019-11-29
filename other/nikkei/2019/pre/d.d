import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

int[][10^^5] NS;
int[10^^5] ORIGIN, DEPS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..N+M-1) {
        auto ab = readln.split.to!(int[]);
        NS[ab[1]-1] ~= ab[0]-1;
    }

    int root;
    foreach (i; 0..N) {
        if (NS[i].empty) {
            root = i;
            break;
        }
    }
    ORIGIN[0..N] = -1;

    int deps(int me) {
        if (me == root) return 0;
        if (ORIGIN[me] != -1) return DEPS[me];
        auto cs = NS[me];
        int p, d = -1;
        foreach (c; cs) {
            auto dd = deps(c);
            if (d < dd) {
                p = c;
                d = dd;
            }
        }
        ORIGIN[me] = p;
        DEPS[me] = d+1;
        return d+1;
    }

    foreach (i; 0..N) {
        if (i == root || ORIGIN[i] != -1) continue;
        deps(i);
    }

    foreach (org; ORIGIN[0..N]) {
        writeln(org+1);
    }
}