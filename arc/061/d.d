import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias P = Tuple!(int, "x", int, "y");

long[10] R;
P[10^^5*10] PS;

void main()
{
    auto hwn = readln.split.to!(long[]);
    auto H = hwn[0];
    auto W = hwn[1];
    auto N = hwn[2];

    R[0] = (H-2) * (W-2);

    int i;
    foreach (_; 0..N) {
        auto ab = readln.split.to!(int[]);
        foreach (yd; [-1, 0, 1]) {
            foreach (xd; [-1, 0, 1]) {
                auto x = ab[1] + xd;
                auto y = ab[0] + yd;
                if (x <= 1 || x >= W || y <= 1 || y >= H) continue;
                PS[i++] = P(x, y);
            }
        }
    }
    sort!"a.y == b.y ? a.x < b.x : a.y < b.y"(PS[0..i]);
    if (i) {
        auto pre = PS[0];
        int cnt = 1;
        foreach (p; PS[1..i]) {
            if (pre == p) {
                ++cnt;
            } else {
                --R[0];
                ++R[cnt];
                cnt = 1;
                pre = p;
            }
        }
        --R[0];
        ++R[cnt];
    }

    foreach (r; R) {
        writeln(r);
    }
}