import std.stdio, std.algorithm, std.conv, std.array, std.string, std.math, std.typecons, std.numeric;

void main()
{
    auto mn = readln.split.to!(int[]);
    auto M = mn[0];
    auto N = mn[1];
    auto ab = readln.split.to!(int[]);
    auto A = ab[0];
    auto B = ab[1];

    auto MAP = new int[][](N, M);
    auto cs = new int[][](N, M);
    foreach (i; 0..N) foreach (j, c; readln.split.to!(int[])) MAP[i][j] = c;
    foreach (i; 0..N) {
        int s, c;
        foreach (j; 0..M) {
            if (MAP[i][j] == -1) {
                c = 0;
                s = 0;
                cs[i][j] = -1;
            } else {
                ++c;
                s += MAP[i][j];
                if (c >= A) {
                    if (c > A) s -= MAP[i][j-A];
                    cs[i][j] = s;
                } else {
                    cs[i][j] = -1;
                }
            }
        }
    }
    int min_s = int.max;
    foreach (j; 0..M) {
        int s, c;
        foreach (i; 0..N) {
            if (cs[i][j] == -1) {
                c = 0;
                s = 0;
            } else {
                ++c;
                s += cs[i][j];
                if (c >= B) {
                    if (c > B) s -= cs[i-B][j];
                    min_s = min(min_s, s);
                }
            }
        }
    }
    writeln(min_s);
}