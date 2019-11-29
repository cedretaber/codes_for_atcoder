import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    foreach (x; 34425L..20181225L) {
        if (x >= 10000000) {
            auto a1 = x / 10000000;
            auto b1 = x % 10000000 / 1000000;
            auto c = x % 1000000;
            if (a1^^b1*c == x) goto ok;
            auto a2 = x % 1000000 / 100000;
            auto b2 = x % 100000 / 10000;
            c = x % 10000;
            if (a1^^b1*a2^^b2*c == x) goto ok;
            auto a3 = x % 10000 / 1000;
            auto b3 = x % 1000 / 100;
            c = x % 100;
            if (a1^^b1*a2^^b2*a3^^b3*c == x) goto ok;
        } else if (x >= 1000000) {
            auto a1 = x / 1000000;
            auto b1 = x % 1000000 / 100000;
            auto c = x % 100000;
            if (a1^^b1*c == x) goto ok;
            auto a2 = x % 100000 / 10000;
            auto b2 = x % 10000 / 1000;
            c = x % 1000;
            if (a1^^b1*a2^^b2*c == x) goto ok;
            auto a3 = x % 1000 / 100;
            auto b3 = x % 100 / 10;
            c = x % 10;
            if (a1^^b1*a2^^b2*a3^^b3*c == x) goto ok;
        } else if (x >= 100000) {
            auto a1 = x / 100000;
            auto b1 = x % 100000 / 10000;
            auto c = x % 10000;
            if (a1^^b1*c == x) goto ok;
            auto a2 = x % 10000 / 1000;
            auto b2 = x % 1000 / 100;
            c = x % 100;
            if (a1^^b1*a2^^b2*c == x) goto ok;
        } else if (x >= 10000) {
            auto a1 = x / 10000;
            auto b1 = x % 10000 / 1000;
            auto c = x % 1000;
            if (a1^^b1*c == x) goto ok;
            auto a2 = x % 1000 / 100;
            auto b2 = x % 100 / 10;
            c = x % 10;
            if (a1^^b1*a2^^b2*c == x) goto ok;
        }
        continue;
        ok:
        writeln(x);
    }
}