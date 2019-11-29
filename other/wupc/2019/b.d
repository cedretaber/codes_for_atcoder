import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto hw = readln.split.to!(int[]);
    auto H = hw[0];
    auto W = hw[1];
    auto MAP = new int[][](H, W);  
    bool five, all_five = true;
    int max_a;
    foreach (i; 0..H) {
        foreach (j, a; readln.split.to!(int[])) {
            MAP[i][j] = a;
            if (a == 5) five = true;
            max_a = max(a, max_a);
        }
    }
    if (max_a == 0) {
        writeln("Yes 0");
    } else if (!five) {
        writeln("No");
    } else if (H == 1 || W == 1) {
        int[] L, R;
        auto N = max(H, W);
        L.length = N;
        R.length = N;
        max_a = 0;
        foreach (i; 0..N) {
            max_a = max(max_a, MAP[H == 1 ? 0 : i][W == 1 ? 0 : i]);
            L[i] = max_a;
        }
        max_a = 0;
        foreach_reverse (i; 0..N) {
            max_a = max(max_a, MAP[H == 1 ? 0 : i][W == 1 ? 0 : i]);
            R[i] = max_a;
        }
        int cnt = int.max;
        foreach (i; 0..N) if (MAP[H == 1 ? 0 : i][W == 1 ? 0 : i] == 5) {
            int c = 1;
            switch (L[i]) {
                case 6: case 7: c += 1; break;
                case 8: c += 2; break;
                case 9: c += 3; break;
                default:
            }
            switch (R[i]) {
                case 6: case 7: c += 1; break;
                case 8: c += 2; break;
                case 9: c += 3; break;
                default:
            }
            cnt = min(cnt, c);
        }
        writefln("Yes %d", cnt);
    } else {
        switch (max_a) {
            case 6: case 7:
                writeln("Yes 2");
                return;
            case 8:
                writeln("Yes 3");
                return;
            case 9:
                writeln("Yes 4");
                return;
            default:
                writeln("Yes 1");
        }
    }
}