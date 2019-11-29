import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric;

alias M = Tuple!(int, "a", int, "b", int, "c");

void main()
{
    immutable nm = readln.chomp.split(" ").map!(to!int).array;
    immutable n = nm[0];
    immutable ma = nm[1];
    immutable mb = nm[2];

    auto meds = new M[n];
    foreach(i, ref m; meds) {
        auto abc = readln.chomp.split(" ").map!(to!int).array;
        m = M(abc[0], abc[1], abc[2]);
    }
    meds.sort!((a, b) => a.c < b.c);

    auto carts = [M(0, 0, 0)];
    auto min_c = int.max;
    foreach (med; meds) {
        carts = carts.map!((cart) {
            auto a = cart.a + med.a;
            auto b = cart.b + med.b;
            auto div = gcd(a, b);
            auto new_cart = cart;

            if (div) {
                new_cart.a = a / div;
                new_cart.b = b / div;
            } else {
                new_cart.a = a;
                new_cart.b = b;
            }

            new_cart.c += med.c;

            if (new_cart.a == ma && new_cart.b == mb && min_c > new_cart.c)
                min_c = new_cart.c;

            return [new_cart, cart];
        }).join;

        if (min_c < int.max)
            break;
    }

    writeln(min_c == int.max ? -1 : min_c);
}