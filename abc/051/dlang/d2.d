import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

alias Path = Tuple!(int, "from", int, "to", int, "weight");

auto make_node()
{
    int[100][100] ret;
    foreach (ref l; ret) foreach (ref e; l) e = int.max / 2;
    return ret;
}

auto NS = make_node();
Path[1000] PS;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..M) {
        auto abc = readln.split.to!(int[]);
        auto a = abc[0] - 1;
        auto b = abc[1] - 1;
        auto c = abc[2];
        PS[i] = Path(a, b, c);
        NS[a][b] = c;
        NS[b][a] = c;
    }

    foreach (k; 0..N)
        foreach (i; 0..N)
            foreach (j; 0..N)
                if (NS[i][j] > NS[i][k] + NS[k][j])
                    NS[i][j] = NS[i][k] + NS[k][j];

    int cnt;
    foreach (p; PS[0..M]) if (p.weight != NS[p.from][p.to]) ++cnt;
    writeln(cnt);
}