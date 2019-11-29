import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias LR = Tuple!(int, "l", int, "r");

LR[10^^4] DS;

void main()
{
    auto ndk = readln.split.to!(int[]);
    auto N = ndk[0];
    auto D = ndk[1];
    auto K = ndk[2];

    foreach (i; 0..D) {
        auto lr = readln.split.to!(int[]);
        DS[i] = LR(lr[0], lr[1]);
    }

    foreach (_; 0..K) {
        auto st = readln.split.to!(int[]);
        auto S = st[0];
        auto T = st[1];

        int edge = S;
        foreach (int i, lr; DS[0..D]) {
            if (lr.l <= edge && edge <= lr.r) {
                if (lr.l <= T && T <= lr.r) {
                    writeln(i+1);
                    break;
                }
                if (T < S) {
                    edge = lr.l;
                } else {
                    edge = lr.r;
                }
            }
        }
    }
}