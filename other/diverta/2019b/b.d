import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

alias Ball = Tuple!(int, "x", int, "y");
Ball[50] BS;

void main()
{
    auto N = readln.chomp.to!int;
    foreach (i; 0..N) {
        auto xy = readln.split.to!(int[]);
        BS[i] = Ball(xy[0], xy[1]);
    }
    if (N == 1) {
        writeln(1);
        return;
    }

    sort(BS[0..N]);
    int r = int.max;
    foreach (a; 0..N) {
        foreach (b; a+1..N) {
            auto x = BS[a].x - BS[b].x;
            auto y = BS[a].y - BS[b].y;
            if (x == 0 && y == 0) continue;
            bool[] FS;
            FS.length = N;
            int rr;
            foreach (i; 0..N) {
                if (FS[i]) continue;
                FS[i] = true;
                ++rr;
                void search(int j, int p) {
                    foreach (k; 0..N) {
                        if (BS[j].x + x*p == BS[k].x && BS[j].y + y*p == BS[k].y && !FS[k]) {
                            FS[k] = true;
                            search(k, p);
                            break;
                        }
                    }
                }
                search(i, 1);
                search(i, -1);
            }
            r = min(r, rr);
        }
    }
    writeln(r);
}