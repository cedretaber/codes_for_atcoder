import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto nl = readln.split.to!(int[]);
    auto N = nl[0];
    long L = nl[1];
    auto xs = new bool[](L+1);
    foreach (x; readln.split.to!(int[])) xs[x] = true;
    auto ts = readln.split.to!(long[]);
    auto T1 = ts[0];
    auto T2 = ts[1];
    auto T3 = ts[2];

    auto LS = new long[](L+1);
    LS[] = long.max/3;
    LS[0] = 0;
    foreach (i; 0..L) {
        auto t1 = LS[i] + T1;
        if (xs[i+1]) t1 += T3;
        LS[i+1] = min(LS[i+1], t1);

        if (i+2 > L) {
            LS[L] = min(LS[L], LS[i] + T1/2 + ((L-i) * 2 - 1) * T2 / 2);
        } else {
            auto t2 = LS[i] + T1 + T2;
            if (xs[i+2]) t2 += T3;
            LS[i+2] = min(LS[i+2], t2);
        }

        if (i+4 > L) {
            LS[L] = min(LS[L], LS[i] + T1/2 + ((L-i) * 2 - 1) * T2 / 2);
        } else {
            auto t3 = LS[i] + T1 + T2 * 3;
            if (xs[i+4]) t3 += T3;
            LS[i+4] = min(LS[i+4], t3);
        }
    }

    writeln(LS[L]);
}