import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;
import std.container.dlist;


alias M = Tuple!(long, "x", long, "h");

void main()
{
    auto nda = readln.split.to!(long[]);
    auto N = nda[0];
    auto D = nda[1];
    auto A = nda[2];
    M[] MS;
    foreach (_; 0..N) {
        auto xh = readln.split.to!(long[]);
        MS ~= M(xh[0], xh[1]);
    }
    sort!"a.x < b.x"(MS);

    auto deq = DList!M();
    long d, x;
    foreach (m; MS) {
        while (!deq.empty && deq.front.x < m.x) {
            d -= deq.front.h;
            deq.removeFront();
        }
        auto h = m.h - d;
        if (h <= 0) continue;
        auto y = (h + A - 1) / A;
        x += y;
        d += A*y;
        deq.insertBack(M(m.x + D*2, A*y));
    }
    writeln(x);
}