import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.bigint, std.container;

alias Path = Tuple!(int, "to", long, "yen", long, "snook");
alias Route = Tuple!(long, "cost", int, "exchange");

Path[][10^^5] GR;
long[10^^5] S_MIN, T_MIN;
Route[10^^5] SUM_MIN;

void main()
{
    auto nmst = readln.split.to!(int[]);
    auto n = nmst[0];
    auto m = nmst[1];
    auto s = nmst[2] - 1;
    auto t = nmst[3] - 1;

    foreach (_; 0..m) {
        auto uvab = readln.split;
        auto u = uvab[0].to!int - 1;
        auto v = uvab[1].to!int - 1;
        auto a = uvab[2].to!long;
        auto b = uvab[3].to!long;
        GR[u] ~= Path(v, a, b);
        GR[v] ~= Path(u, a, b);
    }

    bool[int] memo;
    auto store = [tuple(s, 0L)];
    store.length = (10^^5)*2;
    auto heap = heapify!"a[1] > b[1]"(store, 1);
    while (!heap.empty) {
        auto h = heap.front;
        heap.popFront;
        auto i = h[0];
        if (i in memo) continue;
        memo[i] = true;
        auto c = h[1];
        S_MIN[i] = c;
        foreach (path; GR[i]) {
            heap.insert(tuple(path.to, c + path.yen));
        }
    }

    bool[int] memo2;
    store = [tuple(t, 0L)];
    store.length = (10^^5)*2;
    heap = heapify!"a[1] > b[1]"(store, 1);
    while (!heap.empty) {
        auto h = heap.front;
        heap.popFront;
        auto i = h[0];
        if (i in memo2) continue;
        memo2[i] = true;
        auto c = h[1];
        T_MIN[i] = c;
        foreach (path; GR[i]) {
            heap.insert(tuple(path.to, c + path.snook));
        }
    }

    foreach (i; 0..n) {
        SUM_MIN[i] = Route(S_MIN[i] + T_MIN[i], i);
    }
    sort(SUM_MIN[0..n]);

    auto rest = SUM_MIN[0..n];
    long hand = 10L^^15;
    foreach (i; 0..n) {
        while (rest[0].exchange < i) rest = rest[1..$];
        writeln(hand - rest[0].cost);
    }
}