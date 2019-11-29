import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] WS, HS;

void main()
{
    auto hwk = readln.split.to!(long[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];

    HS[0..H] = W;
    WS[0..W] = H;

    foreach (_; 0..K) {
        auto rc = readln.split.to!(long[]);
        --HS[rc[0]-1];
        --WS[rc[1]-1];
    }
    long mid = (W * H - K) / 2;

    long hs, hm, ws, wm;
    foreach (long i, h; HS) {
        hs += h;
        if (hs > mid) {
            hm = i;
            break;
        }
    }
    foreach (long i, w; WS) {
        ws += w;
        if (ws > mid) {
            wm = i;
            break;
        }
    }

    long r;
    foreach (long i, h; HS) {
        r += abs(hm - i) * h;
    }
    foreach (long i, w; WS) {
        r += abs(wm - i) * w;
    }

    writeln(r);
}