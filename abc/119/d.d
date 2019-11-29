import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

long[10^^5] AS, BS, AS2B, BS2A;

void main()
{
    auto abq = readln.split.to!(int[]);
    auto A = abq[0];
    auto B = abq[1];
    auto Q = abq[2];

    foreach (i; 0..A) AS[i] = readln.chomp.to!long;
    foreach (i; 0..B) BS[i] = readln.chomp.to!long;

    int i;
    foreach (j, a; AS[0..A]) {
        if (i == B-1) {
            AS2B[j] = BS[i];
        } else if (abs(a - BS[i]) < abs(a - BS[i+1])) {
            AS2B[j] = BS[i];
        } else {
            AS2B[j] = BS[++i];
        }
    }
    i = 0;
    foreach (j, b; BS[0..B]) {
        if (i == A-1) {
            BS2A[j] = AS[i];
        } else if (abs(b - AS[i]) < abs(b - AS[i+1])) {
            BS2A[j] = AS[i];
        } else {
            BS2A[j] = AS[++i];
        }
    }

    foreach (_; 0..Q) {
        auto q = readln.chomp.to!long;

        int al = -1, bl = -1, ar = A, br = B;
        while (ar - al != 1) {
            auto mid = (al + ar) / 2;
            if (AS[mid] > q) {
                ar = mid;
            } else {
                al = mid;
            }
        }
        while (br - bl != 1) {
            auto mid = (bl + br) / 2;
            if (BS[mid] > q) {
                br = mid;
            } else {
                bl = mid;
            }
        }

        auto max_l = long.max / 4;

        auto ald = al == -1 ? max_l : q - AS[al];
        auto bld = bl == -1 ? max_l : q - BS[bl];
        auto ard = ar == A ? max_l : AS[ar] - q;
        auto brd = br == B ? max_l : BS[br] - q;

        writeln(min(
            max(ald, bld),
            max(ard, brd),
            ald*2 + brd,
            ard*2 + bld,
            bld*2 + ard,
            brd*2 + ald,
            ald + (al == -1 ? max_l : abs(AS2B[al] - AS[al])),
            ard + (ar == A ? max_l : abs(AS2B[ar] - AS[ar])),
            bld + (bl == -1 ? max_l : abs(BS2A[bl] - BS[bl])),
            brd + (br == B ? max_l : abs(BS2A[br] - BS[br]))
        ));
    }
}