import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container, std.range;

alias X = Tuple!(int, "i", long, "b");

void main()
{
    auto N = readln.chomp.to!int;
    auto AS = readln.split.to!(long[]);
    auto BS = readln.split.to!(long[]);

    X[] xs;
    foreach (i; 0..N) xs ~= X(i, BS[i]);
    auto Q = heapify!"a.b < b.b"(xs);

    long res;
    auto prev = X(-1, -1);
    while (!Q.empty) {
        auto h = Q.front;
        Q.removeFront();

        if (h == prev) {
            writeln(-1);
            return;
        }
        prev = h;

        with (h) {
            auto a = BS[(i+N-1)%N];
            auto c = BS[(i+1)%N];
            auto n = b - AS[i];
            if (n == 0) continue;
            res += n/(a+c);
            b = AS[i] + n%(a+c);
            BS[i] = b;
            h.b = b;
            if (b != 0) Q.insert(h);
        }
    }
    foreach (i; 0..N) if (AS[i] != BS[i]) {
        writeln(-1);
        return;
    }
    writeln(res);
}