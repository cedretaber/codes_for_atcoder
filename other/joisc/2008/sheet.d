import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

void main()
{
    auto nwh = readln.split.to!(int[]);
    auto N = nwh[0];
    auto W = nwh[1];
    auto H = nwh[2];

    auto T = new int[][](H, W);
    auto t = new int[](N+1);
    t[] = -1;
    auto l = new int[](N+1);
    l[] = W;
    auto r = new int[](N+1);
    r[] = -1;
    auto b = new int[](N+1);
    b[] = H;
    foreach (i; 0..H) {
        foreach (j, c; readln.split.to!(int[])) {
            T[i][j] = c;
            t[c] = max(t[c], i);
            l[c] = min(l[c], j.to!int);
            r[c] = max(r[c], j.to!int);
            b[c] = min(b[c], i);
        }
    }

    auto G = new int[][N];
    auto ns = new int[](N);
    foreach (k; 1..N+1) {
        foreach (i; b[k]..t[k]+1) {
            foreach (j; l[k]..r[k]+1) {
                if (T[i][j] != k) {
                    G[k-1] ~= T[i][j]-1;
                }
            }
        }
        sort(G[k-1]);
        G[k-1] = G[k-1].uniq().array();
        foreach (j; G[k-1]) ++ns[j];
    }
    int[] ds;
    foreach (i, n; ns) if (n == 0) ds ~= i.to!int;

    int[] rs;
    while (!ds.empty) {
        auto i = ds[0];
        ds = ds[1..$];
        rs ~= i+1;
        foreach (j; G[i]) {
            --ns[j];
            if (ns[j] == 0) ds ~= j;
        }
    }
    writeln(rs.to!(string[]).join(" "));
}