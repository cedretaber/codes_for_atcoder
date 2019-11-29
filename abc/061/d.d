import std.stdio, std.algorithm, std.conv, std.array, std.string, std.typecons;

alias Edge = Tuple!(int, "from", int, "to", int, "point");

long[1001] VS = long.min / 2;
Edge[2000] ES;

void main()
{
    auto nm = readln.split.to!(int[]);
    auto N = nm[0];
    auto M = nm[1];

    foreach (i; 0..M) {
        auto abc = readln.split.to!(int[]);
        ES[i] = Edge(abc[0], abc[1], abc[2]);
    }

    VS[1] = 0;

    foreach (_; 0..N)
        foreach (e; ES[0..M])
            if (VS[e.from] + e.point > VS[e.to])
                VS[e.to] = VS[e.from] + e.point;

    auto max_n = VS[N];

    foreach (e; ES[0..M])
        if (VS[e.from] + e.point > VS[e.to])
            VS[e.to] = VS[e.from] + e.point;

    writeln(max_n == VS[N] ? max_n.to!string : "inf");
}