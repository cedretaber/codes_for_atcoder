import std.stdio, std.string, std.array, std.algorithm, std.conv, std.typecons, std.numeric, std.math;

void main()
{
    auto hwk = readln.split.to!(int[]);
    auto H = hwk[0];
    auto W = hwk[1];
    auto K = hwk[2];
    long[][] MAP;
    foreach (_; 0..H) MAP ~= readln.chomp.split("").to!(long[]);

    long solve(long[][] mm) {
        auto changed = true;
        long r, c;
        while (changed) {
            foreach_reverse (i; 0..H) {
                foreach (j; 0..W) {
                    if (mm[i][j] == 0) {
                        foreach_reverse (k; 0..i) if (mm[k][j] > 0) {
                            mm[i][j] = mm[k][j];
                            mm[k][j] = 0;
                            break;
                        }
                    }
                }
            }
            changed = false;
            foreach (i; 0..H) {
                foreach_reverse (l; K..W+1) {
                    foreach (x; 0..W+1-l) if (mm[i][x] > 0) {
                        foreach (j; x+1..x+l) if (mm[i][x] != mm[i][j]) goto ng;
                        changed = true;
                        r += mm[i][x] * l * 2L^^c;
                        foreach (j; x..x+l) mm[i][j] = 0;
                        ng:
                    }
                }
            }
            ++c;
        }
        return r;
    }

    long r;
    foreach (i; 0..H) {
        foreach (j; 0..W) {
            auto mm = new long[][](H, W);
            foreach (y; 0..H) foreach (x; 0..W) if (y != i || x != j) mm[y][x] = MAP[y][x];
            r = max(r, solve(mm));
        }
    }
    writeln(r);
}