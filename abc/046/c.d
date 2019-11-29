import std.stdio, std.algorithm, std.conv, std.array, std.string;

void main()
{
    ulong t = 1, a = 1;
    auto n = readln.chomp.to!int;

    foreach (_i; 0..n) {
        ulong tp, ap;
        readf("%d %d", &tp, &ap); readln;

        auto tpd = t / tp;
        auto tpr = t % tp;
        auto apd = a / ap;
        auto apr = a % ap;

        if (tpd > apd) {
            if (tpr) {
                t = tp * (tpd+1);
                a = ap * (tpd+1);
            } else {
                t = tp * tpd;
                a = ap * tpd;
            }
        } else {
            if (apr) {
                t = tp * (apd+1);
                a = ap * (apd+1);
            } else {
                t = tp * apd;
                a = ap * apd;
            }
        }
    }

    writeln(t + a);
}