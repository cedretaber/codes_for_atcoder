import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric, std.container;

alias A = Tuple!(int, "a", long, "c");

void main()
{
    auto N = readln.chomp.to!int;
    int[int] aa, ii;
    foreach (i, a; readln.split.to!(int[])) {
        if (a !in ii) {
            ii[a] = i.to!int;
            aa[a] = 0;
        }
        ++aa[a];
    }
    A[] buf;
    foreach (a, c; aa) buf ~= A(a, c);
    auto Q = heapify!"a.a < b.a"(buf);

    auto res = new long[](N);
    for (;;) {
        auto a = Q.front.a;
        auto c = Q.front.c;
        Q.popFront();
        if (Q.empty) {
            res[ii[a]] += a * c;
            break;
        } else {
            auto n = Q.front;
            Q.popFront();
            auto d = a - n.a;
            res[ii[a]] += d * c;
            Q.insert(A(n.a, n.c + c));
            ii[n.a] = min(ii[a], ii[n.a]);
        }
    }
    foreach (r; res) writeln(r);
}